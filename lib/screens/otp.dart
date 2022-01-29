import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobs_ui/screens/selector.dart';
import 'package:jobs_ui/utlis/colors.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:http/http.dart' as http;
import 'Category.dart';
import 'agent.dart';
import 'employee.dart';
import 'employer.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  final String type;
  final String companyName;
  final String personName;
  final String gender;
  final String emailID;
  final String panNo;
  final String aboutSelf;
  final String GST;
  final String address;
  OTPScreen(
      this.phoneNumber,
      this.type,
      this.companyName,
      this.personName,
      this.aboutSelf,
      this.address,
      this.gender,
      this.emailID,
      this.GST,
      this.panNo);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String _verificationCode = "";
  String URLforAgent =
      "https://project098-5de87-default-rtdb.firebaseio.com/Agents.json";
  String URLforEmployer =
      "https://project098-5de87-default-rtdb.firebaseio.com/Employer.json";
  String URLforEmployee =
      "https://project098-5de87-default-rtdb.firebaseio.com/Employee.json";
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    _verifyPhoneNumber();
    super.initState();
  }

  sendAgentData() async {
    var res = await http.post(Uri.parse(URLforAgent),
        body: json.encode({
          'name': widget.personName,
          'phoneNumber': widget.phoneNumber,
          'email': widget.emailID,
          'address': widget.address,
          'aboutSelf': widget.aboutSelf,
          'gender': widget.gender
        }));
    if (res.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Agent()));
    } else {
      Fluttertoast.showToast(msg: "Something Went Wrong");
    }
  }

  sendEmployerData() async {
    var res = await http.post(Uri.parse(URLforEmployer),
        body: json.encode({
          'name': widget.personName,
          'phoneNumber': widget.phoneNumber,
          'email': widget.emailID,
          'address': widget.address,
          'aboutSelf': widget.aboutSelf,
          'gender': widget.gender,
          'pan Number': widget.panNo,
          'Gst Number': widget.GST,
          'company Name': widget.companyName
        }));
    if (res.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Employer()));
    } else {
      Fluttertoast.showToast(msg: "Something Went Wrong");
    }
  }

  sendEmployeeData() async {
    var res = await http.post(Uri.parse(URLforEmployee),
        body: json.encode({
          'name': widget.personName,
          'phoneNumber': widget.phoneNumber,
          'email': widget.emailID,
          'address': widget.address,
          'aboutSelf': widget.aboutSelf,
          'gender': widget.gender
        }));
    if (res.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Category()));
    } else {
      Fluttertoast.showToast(msg: "Something Went Wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/back.png"),
                        fit: BoxFit.cover)),
                // child: Image.asset(
                //
                //   height: MediaQuery.of(context).size.height * 0.5,
                //   width: MediaQuery.of(context).size.width * 1,
                // ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "OTP Verification",
              style: TextStyle(
                  color: Color(0xff897A5F),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Enter OTP Sent to +91" + widget.phoneNumber,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            OtpTextField(
              numberOfFields: 6,
              borderColor: Color(0xFF512DA8),
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode,
                          smsCode: verificationCode))
                      .then((value) async {
                    if (value.user != null) {
                      if (widget.type.contains("Agent")) {
                        await sendAgentData();
                      } else if (widget.type.contains("Employer")) {
                        await sendEmployerData();
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Employer()));
                      } else {
                        await sendEmployeeData();
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Employee()));
                      }
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => SelectLocation()));
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  _scaffoldkey.currentState!
                      .showSnackBar(SnackBar(content: Text("Invalid Code")));
                }
              }, // end onSubmit
            ),
          ],
        ),
      ),
    );
  }

  _verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91' + widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential ceredentials) async {
        await FirebaseAuth.instance
            .signInWithCredential(ceredentials)
            .then((value) async {
          if (value.user != null) {
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => SelectLocation()));
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}

// class OTP extends StatefulWidget {
//   const OTP({Key? key}) : super(key: key);
//
//   @override
//   _OTPState createState() => _OTPState();
// }
//
// class _OTPState extends State<OTP> {
//   @override
//   Widget build(BuildContext context) {
//     var screenwidth = MediaQuery.of(context).size.width;
//     var screenheight = MediaQuery.of(context).size.height;
//     var blockSizeHorizontal = (screenwidth / 100);
//     var blockSizeVertical = (screenheight / 100);
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: colorBackground,
//         leading: InkWell(
//           onTap: () => Navigator.pop(context),
//           child: Padding(
//             padding: const EdgeInsets.all(18.0),
//             child: Image.asset("assets/images/back.png"),
//           ),
//         ),
//       ),
//       resizeToAvoidBottomInset: false,
//       backgroundColor: colorBackground,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//               vertical: blockSizeVertical, horizontal: screenwidth / 12),
//           child: Column(
//             children: [
//               Container(
//                 width: screenwidth,
//                 height: screenwidth / 1.8,
//                 decoration: BoxDecoration(
//                   color: Colors.deepPurple.shade50,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Image.asset(
//                   'assets/images/illustration-3.png',
//                 ),
//               ),
//               SizedBox(
//                 height: screenheight * .03,
//               ),
//               const Text(
//                 'Verification',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: screenheight * .01,
//               ),
//               const Text(
//                 "Enter your OTP code number",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black38,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: screenheight * .03,
//               ),
//               Container(
//                 padding: EdgeInsets.all(screenheight * .04),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         _textFieldOTP(first: true, last: false),
//                         _textFieldOTP(first: false, last: false),
//                         _textFieldOTP(first: false, last: false),
//                         _textFieldOTP(first: false, last: true),
//                       ],
//                     ),
//                     SizedBox(
//                       height: screenheight * .04,
//                     ),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Navigator.of(context).push(
//                           //   MaterialPageRoute(
//                           //       builder: (context) => const Select()),
//                           // );
//                         },
//                         style: ButtonStyle(
//                           foregroundColor:
//                               MaterialStateProperty.all<Color>(Colors.white),
//                           backgroundColor: MaterialStateProperty.all<Color>(
//                               Colors.lightBlueAccent),
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                             ),
//                           ),
//                         ),
//                         child: const Padding(
//                           padding: EdgeInsets.all(14.0),
//                           child: Text(
//                             'Verify',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 18,
//               ),
//               const Text(
//                 "Didn't you receive any code?",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black38,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(
//                 height: 18,
//               ),
//               const Text(
//                 "Resend New Code",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.purple,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _textFieldOTP({required bool first, last}) {
//     return Container(
//       height: 55,
//       child: AspectRatio(
//         aspectRatio: 1.0,
//         child: TextField(
//           autofocus: true,
//           onChanged: (value) {
//             if (value.length == 1 && last == false) {
//               FocusScope.of(context).nextFocus();
//             }
//             if (value.isEmpty && first == false) {
//               FocusScope.of(context).previousFocus();
//             }
//           },
//           showCursor: false,
//           readOnly: false,
//           textAlign: TextAlign.center,
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           keyboardType: TextInputType.number,
//           maxLength: 1,
//           decoration: InputDecoration(
//             counter: const Offstage(),
//             enabledBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(width: 2, color: Colors.black12),
//                 borderRadius: BorderRadius.circular(12)),
//             focusedBorder: OutlineInputBorder(
//                 borderSide:
//                     const BorderSide(width: 2, color: Colors.lightBlueAccent),
//                 borderRadius: BorderRadius.circular(12)),
//           ),
//         ),
//       ),
//     );
//   }
// }
