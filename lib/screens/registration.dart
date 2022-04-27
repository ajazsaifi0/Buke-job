import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jobs_ui/screens/employee.dart';
import 'package:jobs_ui/screens/login.dart';
import 'package:jobs_ui/utlis/colors.dart';
import 'package:jobs_ui/utlis/constants.dart';
import 'package:jobs_ui/widgets/text_button.dart';

import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  final type;
  final from;
  Register({this.type,this.from});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController companyName = new TextEditingController();
  TextEditingController personName = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController emailId = new TextEditingController();
  TextEditingController panNo = new TextEditingController();
  TextEditingController gstNo = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController aboutSelf = new TextEditingController();
  TextEditingController PasswordController = new TextEditingController();
  TextEditingController ConfirmPasswordController = new TextEditingController();
  TextEditingController StartDate = new TextEditingController();
  TextEditingController BankDetail = new TextEditingController();
  TextEditingController IFSCCode = new TextEditingController();
  DateTime? Start_Date;
  List<String> Images=["assets/images/Labour.png","assets/images/Mason.png","assets/images/Steel.png","assets/images/Plumber.png",
    "assets/images/Core-Cutting.png","assets/images/Electrician.png","assets/images/Formwork.png","assets/images/RCC.png",
    "assets/images/Carpenter.png","assets/images/StoneBreaker.png","assets/images/Excavation.png","assets/images/Scaffolding.png",
    "assets/images/Welding.png","assets/images/Plastering.png","assets/images/Flooring.png","assets/images/StonePolishing.png",
    "assets/images/Paint.png","assets/images/Security.png","assets/images/woodPolishing.png","assets/images/CraneOperator.png"];
  List<String> ImageNames=["Labour","Mason","Steel","Plumber","Core-Cutting","Electrician","Formwork","RCC","Carpenter","StoneBreaker","Excavation",
  "Scaffolding","Welding","Plastering","Flooring","StonePolishing","Paint","Security","woodPolishing","CraneOperator"];
  List<String> SubCategory=["assets/images/Craftsman.png","assets/images/Helper.png"];
  List<String> SubCategoryName=["Craftsman","Helper"];
  bool passwordVisibility = true;
  String gender = "male";
  String Worker_Type = "Mason";
  UploadData() async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
  var requestBody={
    "Type":"Employee",
    "Company_name":companyName.text,
    "Name":personName.text,
    "Gender":gender,
    "Mobile_No":phoneNumber.text,
    "Email_Id":emailId.text,
    "Password":PasswordController.text,
    "Pan_No":panNo.text,
    "Gst_No":gstNo.text,
    "Address":address.text,
    "About":aboutSelf.text,
    "Type_Of_Worker":Worker_Type
  };
  var response=await http.post(Uri.parse("https://Bufework.com/Api/object/Signup.php"),headers: <String, String>{'authorization': basicAuth},body: json.encode(requestBody));
    var res=json.decode(response.body);
    print(res);
  if(response.statusCode==200){
    if(res["status"]==true) {
      SubmitAccountDetails();

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
                          //
                          //    : Container(),
                          Row(
                            children: [
                              Text("Name*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                            ],
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
                          //date of birth field
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Text("Enter Date of birth*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.indigo),
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
                          Row(
                            children: [
                              Text("Phone Number*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
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
                          Row(
                            children: [
                              Text("Email*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                            ],
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
                          Row(
                            children: [
                              Text("Password*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              obscureText: true,
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
                          //
                          //     : Container(),
                          //confirm your password
                          Row(
                            children: [
                              Text("Confirm Password*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                            ],
                          ),
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
                          Row(
                            children: [
                              Text("Address*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
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
                          // MyTextField(
                          //   hintText:
                          //       widget.type.toString().contains("Employer")
                          //           ? 'Office Address'
                          //           : 'Address',
                          //   inputType: TextInputType.text,
                          // ),
                          Row(
                            children: [
                              Text("About Yourself*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                            ],
                          ),
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
                          // MyTextField(
                          //   hintText: 'Write About Yourself/Comapny',
                          //   inputType: TextInputType.text,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Bank Details*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: BankDetail,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Bank Details',
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
                            padding: const EdgeInsets.only(left:0),
                            child: Row(
                             // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("IFSC CODE*",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller:IFSCCode,
                              style: kBodyText.copyWith(color: Colors.black),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'IFSC CODE',
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
                            child: DropDown<String>(
                              isExpanded: true,
                              items: ["Male", "Female", "Other"],
                              hint: Text("Male"),
                              icon: Icon(
                                Icons.expand_more,
                                color: Colors.indigo,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  gender = value!;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: DropDown<String>(
                              isExpanded: true,
                              items: ["Mason", "Labour", "Bar Bending/Steel Worker","Plumber","Core Cutting","Electrician","Formwork",
                              "RCC/RMC","Carpenter","Stone Breaker","Excavation","Scaffolding","Welding","Plastering","Tiling / Flooring",
                              "Stone Polishing","Paint/Colouring","Security","Wood Polishing","Crane Operator"],
                              hint: Text("Mason"),
                              icon: Icon(
                                Icons.expand_more,
                                color: Colors.indigo,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  Worker_Type = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                   widget.from!="Agent"? Row(
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
                              color: Colors.indigo,
                            ),

                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                          },
                        ),
                      ],
                    ):Container(),
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
                            aboutSelf.text != ""&&
                        PasswordController.text!="") {

                          showModalBottomSheet(

                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                   GestureDetector(
                                     child: Container(
                                       height:400,
                                       child: GridView.builder(

                                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                               crossAxisCount:2,crossAxisSpacing: 20,mainAxisSpacing: 20),
                                           itemCount: Images.length,
                                           itemBuilder:(BuildContext context, int index){
                                             return new Card(
                                             child: new GridTile(
                                             footer: Center(child:  Text(ImageNames[index],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(Images[index]),
                                )
                              ), //just for testing, will fill with image later
                                );

                                           }),
                                     ),
                                     //for giving the subcategory
                                     onTap: (){
                                       showModalBottomSheet(

                                           context: context,
                                           builder: (context) {
                                             return Column(
                                               mainAxisSize: MainAxisSize.min,
                                               children: <Widget>[
                                                 GestureDetector(
                                                   child: Container(
                                                     height:200,
                                                     child: GridView.builder(

                                                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                             crossAxisCount:2,crossAxisSpacing: 20,mainAxisSpacing: 20),
                                                         itemCount: SubCategory.length,
                                                         itemBuilder:(BuildContext context, int index){
                                                           return new Card(
                                                             child: new GridTile(
                                                                 footer: Center(child:  Text(SubCategoryName[index],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                                                                 child: Padding(
                                                                   padding: const EdgeInsets.all(20.0),
                                                                   child: Image.asset(SubCategory[index]),
                                                                 )
                                                             ), //just for testing, will fill with image later
                                                           );

                                                         }),
                                                   ),
                                                   onTap: (){
                                                     if(PasswordController.text==ConfirmPasswordController.text) {
                                                       UploadData();
                                                     }else{
                                                       Fluttertoast.showToast(msg: "Password didn't match");
                                                     }
                                             }
                                                 )
                                               ],
                                             );
                                           });
                                     },
                                   )
                                  ],
                                );
                              });

                        } else {
                          Fluttertoast.showToast(
                              msg: "please fill all details");
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
  //https://bufe-job-default-rtdb.firebaseio.com/AccountDetails.json
SubmitAccountDetails() async{
var requestBody={
      "Account No": BankDetail.text,
      "IFSC Code": IFSCCode.text
  };
var res=await http.post(Uri.parse("https://bufe-job-default-rtdb.firebaseio.com/"+personName.text+".json"),
    body: json.encode(requestBody));
print(res.body);
if(res.statusCode==200){
  widget.from!="Agent" ?Navigator.push(
      context, MaterialPageRoute(builder: (context) => Login())):
  Fluttertoast.showToast(msg: "Registration is done");
}else{
  Fluttertoast.showToast(msg: "Internal Server Error");
}
}
}

