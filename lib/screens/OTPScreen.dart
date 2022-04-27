import 'dart:convert';

import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobs_ui/Helper%20Function/SF.dart';
import 'package:jobs_ui/utlis/constants.dart';
import 'package:http/http.dart' as http;
import 'agent.dart';
import 'employee.dart';
import 'employer.dart';
class OTPScreen extends StatefulWidget {
final String phoneNumber;
OTPScreen(this.phoneNumber);


  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String? _enteredOTP;
  String? Email;
  String? Password;
  getEmailAndPassword()async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    try {
      var response = await http.post(Uri.parse(
          "https://Bufework.com/Api/object/Otp.php?Mobile_No=" +
              widget.phoneNumber),
          headers: <String, String>{'authorization': basicAuth});
      var res = json.decode(response.body);
      if (res["status"] == true) {
        setState(() {
          Email = res["Email_Id"];
          Password = res["Password"];
        });
        verify_Ceredentials();
      }else{
        Fluttertoast.showToast(msg: "Account not Exist");
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }

  }
  SaveDataInSharedPrefs(String Email,String Password)async{
    await  HelperFunctions.saveUserLoggedInState(true);
    await  HelperFunctions.saveUserNameInSharedPrefrence(Email);
    await  HelperFunctions.savePassword(Password);
  }
  verify_Ceredentials() async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);

    var response=await http.post(Uri.parse("https://Bufework.com/Api/object/Login.php?Email_Id="+Email!+"&Password="+Password!),headers: <String, String>{'authorization': basicAuth});
    var res=json.decode(response.body);
    if(response.statusCode==200){
      if(res["status"]==true) {
        SaveDataInSharedPrefs(Email!,Password!);
        setState(() {
          KEmail_Id=Email!;
        });
        if(res["Type"]=="Employer") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Employer(KEmail_Id,res["Name"],res["Address"],res["About"],res["Type"],res["Gender"],res["Mobile_No"],res["Gst_No"],res["Pan_no"],res["Company_Name"])));
        }else if(res["Type"]=="Agent"){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Agent(KEmail_Id,res["Name"],res["Address"],res["About"],res["Type"],res["Gender"],res["Mobile_No"])));
        }else{
          if(res["Type_Of_Worker"]=="Mason"){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Employee(KEmail_Id,res["Type_Of_Worker"],res["Name"],res["Address"],res["About"],res["Type"],res["Gender"],res["Mobile_No"])));
          }else if(res["Type_Of_Worker"]=="Labour"){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Employee(KEmail_Id,res["Type_Of_Worker"],res["Name"],res["Address"],res["About"],res["Type"],res["Gender"],res["Mobile_No"])));
          }else if(res["Type_Of_Worker"]=="Bar Bending/Steel Worker"){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Employee(KEmail_Id,res["Type_Of_Worker"],res["Name"],res["Address"],res["About"],res["Type"],res["Gender"],res["Mobile_No"])));
          }else if(res["Type_Of_Worker"]=="Plumber"){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Employee(KEmail_Id,res["Type_Of_Worker"],res["Name"],res["Address"],res["About"],res["Type"],res["Gender"],res["Mobile_No"])));
          }else{
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Employee(KEmail_Id,res["Type_Of_Worker"],res["Name"],res["Address"],res["About"],res["Type"],res["Gender"],res["Mobile_No"])));

          }
        }
      }else{
        Fluttertoast.showToast(
            msg: res["message"]);
      }
    }else{
      Fluttertoast.showToast(
          msg: "Something Goes Wrong");
    }
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FirebasePhoneAuthHandler(
        phoneNumber: "+91"+widget.phoneNumber,
        timeOutDuration: const Duration(seconds: 60),
        onLoginSuccess: (userCredential, autoVerified) async {
          // _showSnackBar(
          //   context,
          //   'Phone number verified successfully!',
          // );
          getEmailAndPassword();
          debugPrint(
            autoVerified
                ? "OTP was fetched automatically"
                : "OTP was verified manually",
          );

          debugPrint("Login Success UID: ${userCredential.user?.uid}");
        },
        onLoginFailed: (authException) {
          _showSnackBar(
            context,
            'Something went wrong (${authException.message})',
          );

          debugPrint(authException.message);
          // handle error further if needed
        },
        builder: (context, controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.indigo,
              title: const Text("Verify Phone Number"),
              actions: [
                if (controller.codeSent)
                  TextButton(
                    child: Text(
                      controller.timerIsActive
                          ? "${controller.timerCount.inSeconds}s"
                          : "RESEND",
                      style: const TextStyle(
                        color: Colors.indigo,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: controller.timerIsActive
                        ? null
                        : () async => await controller.sendOTP(),
                  ),
                const SizedBox(width: 5),
              ],
            ),
            body: controller.codeSent
                ? ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  "We've sent an SMS with a verification code to $widget.phoneNumber",
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: controller.timerIsActive ? null : 0,
                  child: Column(
                    children: const [
                      CircularProgressIndicator.adaptive(),
                      SizedBox(height: 50),
                      Text(
                        "Listening for OTP",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Divider(),
                      Text("OR", textAlign: TextAlign.center),
                      Divider(),
                    ],
                  ),
                ),
                const Text(
                  "Enter OTP",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextField(
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  onChanged: (String v) async {
                    _enteredOTP = v;
                    if (_enteredOTP?.length == 6) {
                      final isValidOTP = await controller.verifyOTP(
                        otp: _enteredOTP!,
                      );
                      // Incorrect OTP
                      if (!isValidOTP) {
                        _showSnackBar(
                          context,
                          "Please enter the correct OTP sent to $widget.phoneNumber",
                        );
                      }
                    }
                  },
                ),
              ],
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator.adaptive(),
                SizedBox(height: 50),
                Center(
                  child: Text(
                    "Sending OTP",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
