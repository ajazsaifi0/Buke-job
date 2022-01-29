import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobs_ui/utlis/colors.dart';
import 'package:jobs_ui/utlis/constants.dart';
import 'package:jobs_ui/widgets/text_button.dart';

import 'otp.dart';

class JobPostForm extends StatefulWidget {
  const JobPostForm({Key? key}) : super(key: key);

  @override
  _JobPostFormState createState() => _JobPostFormState();
}

class _JobPostFormState extends State<JobPostForm> {
  String gender = "male";
  TextEditingController projectName = new TextEditingController();
  TextEditingController personCount = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController emailId = new TextEditingController();
  //TextEditingController panNo = new TextEditingController();
  // TextEditingController gstNo = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController aboutproject = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    var blockSizeHorizontal = (screenwidth / 100);
    var blockSizeVertical = (screenheight / 100);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // titleSpacing: blockSizeHorizontal * 40,
        backgroundColor: colorBackground,
        title: const Text(
          "Post Your Requirement",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            color: colorPrimaryText,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: colorBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // widget.type.toString().contains("Employer")
                          //     ? MyTextField(
                          //         hintText: 'Name of the Company',
                          //         inputType: TextInputType.name,
                          //       )
                          //     : Container(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: projectName,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Name of the Project',
                                hintStyle: kBodyText,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.lightBlueAccent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: personCount,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Number of Days',
                                hintStyle: kBodyText,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.lightBlueAccent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: phoneNumber,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Phone No.',
                                hintStyle: kBodyText,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.lightBlueAccent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: emailId,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Email ID',
                                hintStyle: kBodyText,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.lightBlueAccent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 10),
                          //   child: TextField(
                          //     controller: panNo,
                          //     style: kBodyText.copyWith(color: Colors.black),
                          //     keyboardType: TextInputType.name,
                          //     textInputAction: TextInputAction.next,
                          //     decoration: InputDecoration(
                          //       contentPadding: const EdgeInsets.all(20),
                          //       hintText: 'PAN No.',
                          //       hintStyle: kBodyText,
                          //       enabledBorder: OutlineInputBorder(
                          //         borderSide: const BorderSide(
                          //           color: Colors.lightBlueAccent,
                          //           width: 1,
                          //         ),
                          //         borderRadius: BorderRadius.circular(18),
                          //       ),
                          //       focusedBorder: OutlineInputBorder(
                          //         borderSide: const BorderSide(
                          //           color: Colors.grey,
                          //           width: 1,
                          //         ),
                          //         borderRadius: BorderRadius.circular(18),
                          //       ),
                          //     ),
                          //   ),
                          // ),

                          // widget.type.toString().contains("Employer")
                          //     ? MyTextField(
                          //         hintText: 'PAN No.',
                          //         inputType: TextInputType.name,
                          //       )
                          //     : Container(),
                          // widget.type.toString().contains("Employer")
                          //     ? MyTextField(
                          //         hintText: 'GST No.',
                          //         inputType: TextInputType.name,
                          //       )
                          //     : Container(),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 10),
                          //   child: TextField(
                          //     controller: gstNo,
                          //     style: kBodyText.copyWith(color: Colors.black),
                          //     keyboardType: TextInputType.name,
                          //     textInputAction: TextInputAction.next,
                          //     decoration: InputDecoration(
                          //       contentPadding: const EdgeInsets.all(20),
                          //       hintText: 'GST No.',
                          //       hintStyle: kBodyText,
                          //       enabledBorder: OutlineInputBorder(
                          //         borderSide: const BorderSide(
                          //           color: Colors.lightBlueAccent,
                          //           width: 1,
                          //         ),
                          //         borderRadius: BorderRadius.circular(18),
                          //       ),
                          //       focusedBorder: OutlineInputBorder(
                          //         borderSide: const BorderSide(
                          //           color: Colors.grey,
                          //           width: 1,
                          //         ),
                          //         borderRadius: BorderRadius.circular(18),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: address,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Address',
                                hintStyle: kBodyText,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.lightBlueAccent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                          ),
                          // MyTextField(
                          //   hintText:
                          //       widget.type.toString().contains("Employer")
                          //           ? 'Office Address'
                          //           : 'Address',
                          //   inputType: TextInputType.text,
                          // ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: aboutproject,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Detail Description of project',
                                hintStyle: kBodyText,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.lightBlueAccent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                          ),
                          // MyTextField(
                          //   hintText: 'Write About Yourself/Comapny',
                          //   inputType: TextInputType.text,
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 10),
                          //   child: DropDown<String>(
                          //     isExpanded: true,
                          //     items: ["Male", "Female", "Other"],
                          //     hint: Text("Male"),
                          //     icon: Icon(
                          //       Icons.expand_more,
                          //       color: Colors.blue,
                          //     ),
                          //     onChanged: (value) {
                          //       setState(() {
                          //         gender = value!;
                          //       });
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const Text(
                    //       "Already have an account? ",
                    //       style: kBodyText,
                    //     ),
                    //     Text(
                    //       "Sign In",
                    //       style: kBodyText.copyWith(
                    //         color: Colors.lightBlueAccent,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextButton(
                      buttonName: 'Post Job',
                      onTap: () {
                        if (personCount.text != "" &&
                            phoneNumber.text != "" &&
                            emailId.text != "" &&
                            address.text != "" &&
                            aboutproject.text != "" &&
                            projectName.text != "") {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return OTPScreen(
                          //         phoneNumber.text,
                          //         "Employer",
                          //         projectName.text,
                          //         personName.text,
                          //         aboutSelf.text,
                          //         address.text,
                          //         gender,
                          //         emailId.text,
                          //         gstNo.text,
                          //         panNo.text,
                          //       );
                          //     },
                          //   ),
                          // );
                          sendJobData();
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please fill all Details");
                        }
                      },
                      bgColor: Colors.white,
                      textColor: Colors.black87,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  sendJobData() async {
    String url =
        "https://project098-5de87-default-rtdb.firebaseio.com/jobs.json";
    var res = await http.post(Uri.parse(url),
        body: json.encode({
          'Projectname': projectName.text,
          'personCount': personCount.text,
          'phoneNumber': phoneNumber.text,
          'email': emailId.text,
          'address': address.text,
          'Description': aboutproject.text,
        }));
    if (res.statusCode == 200) {
      Fluttertoast.showToast(msg: "job Uploaded");
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: "Something Went Wrong");
    }
  }
}
