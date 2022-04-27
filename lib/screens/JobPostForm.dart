import 'dart:convert';
import 'package:counter_button/counter_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobs_ui/utlis/colors.dart';
import 'package:jobs_ui/utlis/constants.dart';
import 'package:jobs_ui/widgets/text_button.dart';
import 'package:intl/intl.dart';

class JobPostForm extends StatefulWidget {
  late final Type;
  late final Email_id;
  JobPostForm(this.Type,this.Email_id);
  //JobPostForm(t)

  @override
  _JobPostFormState createState() => _JobPostFormState();
}

class _JobPostFormState extends State<JobPostForm> {
  DateTime? Start_Date;
  DateTime? End_Date;
  DateTime? Application_Start_Date;
  DateTime? Application_End_Date;
 int _counterValue=0;
  int _counterValue2=0;
  String gender = "male";
  String formattedDate = "";
  TextEditingController projectName = new TextEditingController();//work_title
  TextEditingController Supervisor_Name = new TextEditingController();//Supervisor Name
  TextEditingController Duration = new TextEditingController();//Duration
  TextEditingController phoneNumber = new TextEditingController();//Mobile Number
  TextEditingController Holiday = new TextEditingController();//Holiday
  TextEditingController Hours_Per_Day = new TextEditingController();//Hours Per Day
  TextEditingController Cost_Per_Hours = new TextEditingController();//Cost Per Hour

  //TextEditingController panNo = new TextEditingController();
  // TextEditingController gstNo = new TextEditingController();
  TextEditingController address = new TextEditingController();//location of work
  TextEditingController aboutproject = new TextEditingController();//Work Description
  TextEditingController StartDate = new TextEditingController();//Start Date
  TextEditingController EndDate = new TextEditingController();//End Date of the Project
  TextEditingController Application_Start_Date_Controller = new TextEditingController();//Start Date
  TextEditingController Application_End_Date_Controller = new TextEditingController();
  TextEditingController No_Of_Employee_Required= new TextEditingController();
  List<String> _dropdownItems=[
    "No Food",
    "Food Included",
    "Water Included"
  ];
  List<String> _Travel_dropdownItems=[
    "Not Included",
    "Included",
    "Partially Included"
  ];
  List<String> _Payment_dropdownItems=[
    "Advance",
    "Partially Advance",
    "After the Project"
  ];
  List<String> _PreferredWorker_dropdownItems=["Mason", "Labour", "Bar Bending/Steel Worker","Plumber"];
   String _FoodDetail="No Food";
   String _TravelDetails="Not Included";
   String _Payment="Advance";
   String _PrefferedWorker="Mason";
  List<String> Images=["assets/images/Labour.png","assets/images/Mason.png","assets/images/Steel.png","assets/images/Plumber.png",
    "assets/images/Core-Cutting.png","assets/images/Electrician.png","assets/images/Formwork.png","assets/images/RCC.png",
    "assets/images/Carpenter.png","assets/images/StoneBreaker.png","assets/images/Excavation.png","assets/images/Scaffolding.png",
    "assets/images/Welding.png","assets/images/Plastering.png","assets/images/Flooring.png","assets/images/StonePolishing.png",
    "assets/images/Paint.png","assets/images/Security.png","assets/images/woodPolishing.png","assets/images/CraneOperator.png"];
  List<String> ImageNames=["Labour","Mason","Steel","Plumber","Core-Cutting","Electrician","Formwork","RCC","Carpenter","StoneBreaker","Excavation",
    "Scaffolding","Welding","Plastering","Flooring","StonePolishing","Paint","Security","woodPolishing","CraneOperator"];
  List<String> SubCategory=["assets/images/Craftsman.png","assets/images/Helper.png"];
  List<String> SubCategoryName=["Craftsman","Helper"];
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

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
                          Row(
                            children: [
                              Text("Enter Title of the project*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: projectName,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Name of the Project/Work',
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
                          Row(
                            children: [
                              Text("Enter Supervisor Name*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: Supervisor_Name,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Name of Supervisor',
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
                          Row(
                            children: [
                              Text("Enter Mobile Number*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                            ],
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
                          Row(
                            children: [
                              Text("Enter Duration of Work*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: Duration,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Duration',
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
                          Row(
                            children: [
                              Text("Enter Address*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                            ],
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
                          Row(
                            children: [
                              Text("Enter Description*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                            ],
                          ),
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
                          Row(
                            children: [
                              Text("Enter Total Hours required per day*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: Hours_Per_Day,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Total Hours Per Day',
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
                          Row(
                            children: [
                              Text("Enter Cost Per Hour*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: Cost_Per_Hours,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Cost Per Hour',
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
                          Row(
                            children: [
                              Text("Enter Number of Holiday*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: Holiday,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Holiday',
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
                          Row(
                            children: [
                              Text("Enter Number of Employees Required*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller:No_Of_Employee_Required,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Employees Required',
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Text("Enter Starting Date Of Project*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                    Container(
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
                                labelText: "Start date of the project",
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
                                  formattedDate =
                                      DateFormat('dd-MMMM-yyyy').format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Text("Enter Ending Date Of Project*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightBlueAccent),
                        borderRadius: BorderRadius.circular(20)
                      ),
                        padding: EdgeInsets.only(left: 20, right: 20, top: 7),
                        child: Center(
                            child: TextField(
                              controller: EndDate, //editing controller of this TextField
                              decoration: InputDecoration(
                                // focusedBorder: OutlineInputBorder(
                                //   borderSide: const BorderSide(
                                //       color: Color(0xff0064ff), width: 2.0),
                                //   borderRadius: BorderRadius.circular(25.0),
                                // ),
                                // icon: Icon(Icons.calendar_today), //icon of text field
                                labelText: "End Date of the project",
                                labelStyle: TextStyle(
                                  color: Colors.black,
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
                                  End_Date=pickedDate;
                                });
                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate1 =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
                                  // age = calculateAge(pickedDate);
                                  // print(age);
                                  formattedDate =
                                      DateFormat('dd-MMMM-yyyy').format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  //you can implement different kind of Date Format here according to your requirement

                                  setState(() {
                                    EndDate.text =
                                        formattedDate1; //set output date to TextField value.
                                  });
                                } else {
                                  print("Date is not selected");
                                }

                              },
                            ))),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Text("Enter Starting Date Of Application*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightBlueAccent),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        padding: EdgeInsets.only(left: 20, right: 20, top: 7),
                        child: Center(
                            child: TextField(
                              controller: Application_Start_Date_Controller, //editing controller of this TextField
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xff0064ff), width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                // icon: Icon(Icons.calendar_today), //icon of text field
                                labelText: "Start Date of the application",
                                labelStyle: TextStyle(
                                  color: Colors.black,
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
                                  Application_Start_Date=pickedDate;
                                });
                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate1 =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
                                  // age = calculateAge(pickedDate);
                                  // print(age);
                                  formattedDate =
                                      DateFormat('dd-MMMM-yyyy').format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  //you can implement different kind of Date Format here according to your requirement

                                  setState(() {
                                    Application_Start_Date_Controller.text =
                                        formattedDate1; //set output date to TextField value.
                                  });
                                } else {
                                  print("Date is not selected");
                                }

                              },
                            ))),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Text("Enter Ending Of The Application*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightBlueAccent),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        padding: EdgeInsets.only(left: 20, right: 20, top: 7),
                        child: Center(
                            child: TextField(
                              controller: Application_End_Date_Controller, //editing controller of this TextField
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xff0064ff), width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                // icon: Icon(Icons.calendar_today), //icon of text field
                                labelText: "End Date of the application",
                                labelStyle: TextStyle(
                                  color: Colors.black,
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
                                  Application_End_Date=pickedDate;
                                });
                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate1 =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
                                  // age = calculateAge(pickedDate);
                                  // print(age);
                                  formattedDate =
                                      DateFormat('dd-MMMM-yyyy').format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  //you can implement different kind of Date Format here according to your requirement

                                  setState(() {
                                   Application_End_Date_Controller.text =
                                        formattedDate1; //set output date to TextField value.
                                  });
                                } else {
                                  print("Date is not selected");
                                }

                              },
                            ))),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Text("Enter Food Allowances Detail*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightBlueAccent),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: FormField(builder: (FormFieldState state) {
                          return DropdownButtonHideUnderline(
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                new InputDecorator(
                                  decoration: InputDecoration(
                                    filled: false,
                                    hintText: 'Food Allowance',
                                    labelText: _FoodDetail == null
                                        ? 'Food Allowance'
                                        : 'Food Allowance',
                                    //  errorText: _errorText,
                                  ),
                                  isEmpty:_FoodDetail == null,
                                  child: new DropdownButton<String>(
                                    value: _FoodDetail,
                                    isDense: true,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _FoodDetail = newValue!;
                                      });
                                      print('${_FoodDetail}');
                                    },
                                    items: _dropdownItems.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Text("Enter Travel Allowances Detail*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightBlueAccent),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: FormField(builder: (FormFieldState state) {
                          return DropdownButtonHideUnderline(
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                new InputDecorator(
                                  decoration: InputDecoration(
                                    filled: false,
                                    hintText: 'Travel Allowance',
                                    labelText: _TravelDetails == null
                                        ? 'Travel Allowance'
                                        : 'Travel Allowance',
                                    //  errorText: _errorText,
                                  ),
                                  isEmpty:_TravelDetails == null,
                                  child: new DropdownButton<String>(
                                    value: _TravelDetails,
                                    isDense: true,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _TravelDetails = newValue!;
                                      });
                                      print('${_TravelDetails}');
                                    },
                                    items: _Travel_dropdownItems.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Text("Enter Payment Detail*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightBlueAccent),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: FormField(builder: (FormFieldState state) {
                          return DropdownButtonHideUnderline(
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                new InputDecorator(
                                  decoration: InputDecoration(
                                    filled: false,
                                    hintText: 'Payment Option',
                                    labelText: _Payment == null
                                        ? 'Payment Option'
                                        : 'Payment Option',
                                    //  errorText: _errorText,
                                  ),
                                  isEmpty:_Payment == null,
                                  child: new DropdownButton<String>(
                                    value: _Payment,
                                    isDense: true,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _Payment= newValue!;
                                      });
                                      print('${_Payment}');
                                    },
                                    items: _Payment_dropdownItems.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Text("Enter Preffered Worker Detail*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightBlueAccent),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: FormField(builder: (FormFieldState state) {
                          return DropdownButtonHideUnderline(
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                new InputDecorator(
                                  decoration: InputDecoration(
                                    filled: false,
                                    hintText: 'Preffered Worker',
                                    labelText: _PrefferedWorker == null
                                        ? 'Preffered Worker'
                                        : 'Preffered Worker',
                                    //  errorText: _errorText,
                                  ),
                                  isEmpty:_PrefferedWorker == null,
                                  child: new DropdownButton<String>(
                                    value: _PrefferedWorker,
                                    isDense: true,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _PrefferedWorker= newValue!;
                                      });
                                      print('${_PrefferedWorker}');
                                    },
                                    items: _PreferredWorker_dropdownItems.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Enter the Craftsman\n number required",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                          ,
                          CounterButton(
                            loading: false,
                            onChange: (int val) {
                              setState(() {
                                _counterValue = val;
                              });
                            },
                            count: _counterValue,
                            countColor: Colors.purple,
                            buttonColor: Colors.purpleAccent,
                            progressColor: Colors.purpleAccent,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Enter the Helper\n number required",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                          ,
                          CounterButton(
                            loading: false,
                            onChange: (int val) {
                              setState(() {
                                _counterValue2 = val;
                              });
                            },
                            count: _counterValue2,
                            countColor: Colors.purple,
                            buttonColor: Colors.purpleAccent,
                            progressColor: Colors.purpleAccent,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextButton(
                      buttonName: 'Post Job',
                      onTap: () {
                        if (Supervisor_Name.text != "" &&
                            phoneNumber.text != "" &&
                            Duration.text != "" &&
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
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    String url =
        "https://Bufework.com/Api/object/Company_Form.php";
    var res = await http.post(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth},
        body: json.encode({
          "Email_Id":widget.Email_id,
         "Type":widget.Type,
          "Title":projectName.text,
          "Supervisor_Name":Supervisor_Name.text,
          "Mobile_No":phoneNumber.text,
          "Work_Start_Date":Start_Date.toString(),
          "Work_End_Date":End_Date.toString(),
          "Location":address.text,
          "Description":aboutproject.text,
          "Food":_FoodDetail,
          "Travel":_TravelDetails,
          "Payment":_Payment,
          "Application_Start_Date":Application_Start_Date.toString(),
          "Application_End_Date":Application_End_Date.toString(),
          "Work_Duration":Duration.text,
          "Holiday":Holiday.text,
          "Hours_Per_Day":Hours_Per_Day.text,
          "Cost_Per_Hour":Cost_Per_Hours.text,
          "Prefferd_Work":_PrefferedWorker,
          "Member":No_Of_Employee_Required.text

          // 'Projectname': projectName.text,
          // 'personCount': personCount.text,
          // 'phoneNumber': phoneNumber.text,
          // 'email': emailId.text,
          // 'address': address.text,
          // 'Description': aboutproject.text,
        }));
    if (res.statusCode == 200) {
      Fluttertoast.showToast(msg: "job Uploaded");
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: "Something Went Wrong");
    }
  }
}
