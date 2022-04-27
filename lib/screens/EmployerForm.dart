import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jobs_ui/screens/employer.dart';
import 'package:jobs_ui/utlis/colors.dart';
import 'package:jobs_ui/utlis/constants.dart';
import 'package:jobs_ui/widgets/text_button.dart';
import 'package:http/http.dart' as http;

import 'login.dart';


class EmployerForm extends StatefulWidget {
  @override
  _EmployerFormState createState() => _EmployerFormState();
}

class _EmployerFormState extends State<EmployerForm> {
  String gender = "male";
  TextEditingController companyName = new TextEditingController();
  TextEditingController personName = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController emailId = new TextEditingController();
  TextEditingController panNo = new TextEditingController();
  TextEditingController gstNo = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController aboutSelf = new TextEditingController();
  TextEditingController PasswordController = new TextEditingController();
  TextEditingController StartDate = new TextEditingController();
  TextEditingController ConfirmPasswordController = new TextEditingController();
  DateTime? Start_Date;
  UploadData() async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var requestBody={
      "Type":"Employer",
      "Company_Name":companyName.text,
      "Name":personName.text,
      "Gender":gender,
      "Mobile_No":phoneNumber.text,
      "Email_Id":emailId.text,
      "Password":PasswordController.text,
      "Pan_No":panNo.text,
      "Gst_No":gstNo.text,
      "Address":address.text,
      "About":aboutSelf.text
    };
    var response=await http.post(Uri.parse("https://Bufework.com/Api/object/Signup.php"),headers: <String, String>{'authorization': basicAuth},body: json.encode(requestBody));
    var res=json.decode(response.body);
    if(response.statusCode==200){
      if(res["status"]==true) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      }else{
        Fluttertoast.showToast(
            msg: res["message"]);
      }
    }else{
      Fluttertoast.showToast(
          msg: "Something Goes Wrong");
    }
  }

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
          "Register",
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
                              controller: companyName,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Name of the Company',
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
                              controller: personName,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Name of Person',
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
                          //date of birth
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 8),
                          //   child: Row(
                          //     children: [
                          //       Text("Enter Date of birth*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                          //     ],
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.lightBlueAccent),
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                padding: EdgeInsets.only(left: 20, right: 20, top: 7),
                                child: Center(
                                    child: TextField(
                                      controller: StartDate, //editing controller of this TextField
                                      decoration: InputDecoration(
                                        // focusedBorder: OutlineInputBorder(
                                        //   borderSide: const BorderSide(
                                        //       color: Color(0xff0064ff), width: 2.0),
                                        //   borderRadius: BorderRadius.circular(25.0),
                                        // ),
                                        // icon: Icon(Icons.calendar_today), //icon of text field
                                        labelText: "Enter date of birth",
                                        labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16
                                        ), //label text of field
                                        //suffixText: age.toString() + " years"
                                      ),
                                      readOnly:
                                      false, //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(
                                                1955), //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime(2101));
                                        setState(() {
                                          Start_Date=pickedDate;
                                        });
                                        if (pickedDate != null) {
                                          print(
                                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                          String formattedDate1 =
                                          DateFormat('dd-MM-yyyy').format(pickedDate);
                                          // age = calculateAge(pickedDate);
                                          // print(age);
                                          // formattedDate =
                                          //     DateFormat('dd-MMMM-yyyy').format(pickedDate);
                                          // print(
                                          //     formattedDate); //formatted date output using intl package =>  2021-03-16
                                          //you can implement different kind of Date Format here according to your requirement

                                          setState(() {
                                            StartDate.text =
                                                formattedDate1; //set output date to TextField value.
                                          });
                                        } else {
                                          print("Date is not selected");
                                        }



                                      },
                                    ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              maxLength: 10,
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: PasswordController,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Enter Your Password',
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
                          //confirm password
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              obscureText: true,
                              controller: ConfirmPasswordController,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Confirm Your Password',
                                hintStyle: kBodyText,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.indigo,
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
                              controller: panNo,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'PAN No.',
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: gstNo,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'GST No.',
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
                              controller: aboutSelf,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Write About Yourself/Comapny',
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: DropDown<String>(
                              isExpanded: true,
                              items: ["Male", "Female", "Other"],
                              hint: Text("Male"),
                              icon: Icon(
                                Icons.expand_more,
                                color: Colors.blue,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  gender = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: kBodyText,
                        ),
                        GestureDetector(
                          child: Text(
                            "Sign In",
                            style: kBodyText.copyWith(
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextButton(
                      buttonName: 'Register',
                      onTap: () {
                        if (personName.text != "" &&
                            phoneNumber.text != "" &&
                            emailId.text != "" &&
                            address.text != "" &&
                            aboutSelf.text != "" &&
                            gstNo.text != "" &&
                            panNo.text != "" &&
                            companyName.text != ""&&
                        PasswordController.text!="") {
                          if(PasswordController.text==ConfirmPasswordController.text) {
                            UploadData();
                          }else{
                            Fluttertoast.showToast(
                                msg: "Password didn't match");
                          }
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
}
