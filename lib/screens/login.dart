import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobs_ui/Helper%20Function/SF.dart';
import 'package:jobs_ui/screens/LoginwithMobileScreen.dart';
import 'package:jobs_ui/screens/agent.dart';
import 'package:jobs_ui/screens/employer.dart';
import 'package:jobs_ui/screens/selector.dart';
import 'package:jobs_ui/utlis/colors.dart';
import 'package:jobs_ui/utlis/constants.dart';
import 'package:jobs_ui/widgets/button.dart';
import 'package:http/http.dart' as http;

import 'employee.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController EmailAddress_Controller = new TextEditingController();
  TextEditingController Password_Controller = new TextEditingController();

  SaveDataInSharedPrefs()async{
  await  HelperFunctions.saveUserLoggedInState(true);
  await  HelperFunctions.saveUserNameInSharedPrefrence(EmailAddress_Controller.text);
  await  HelperFunctions.savePassword(Password_Controller.text);
  }
  verify_Ceredentials() async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);

    var response=await http.post(Uri.parse("https://Bufework.com/Api/object/Login.php?Email_Id="+EmailAddress_Controller.text+"&Password="+Password_Controller.text),headers: <String, String>{'authorization': basicAuth});
    var res=json.decode(response.body);
    if(response.statusCode==200){
      if(res["status"]==true) {
        SaveDataInSharedPrefs();
        setState(() {
          KEmail_Id=EmailAddress_Controller.text;
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
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    var blockSizeHorizontal = (screenwidth / 100);
    var blockSizeVertical = (screenheight / 100);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Image.asset("assets/images/back.png"),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: colorBackground,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/illustration-2.png',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Add your Email Address and Password",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 28,
                ),
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextField(
                          controller: EmailAddress_Controller,
                          style: kBodyText.copyWith(color: Colors.black),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            hintText: 'Enter Email Address',
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
                          controller: Password_Controller,
                          obscureText: true,
                          style: kBodyText.copyWith(color: Colors.black),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            hintText: 'Enter Password',
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

                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                         // Text("New Here"),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginWithMobile()));
                          }, child: Text("Login With Phone"))
                        ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        Text("New Here"),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Select()));
                        }, child: Text("Sign Up"))
                      ],),
                      SizedBox(
                        width: double.infinity,
                        child: ButtonWidget(
                          onPressed: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //       builder: (context) => const OTP()),
                            // );
                            if(EmailAddress_Controller.text!=""&&Password_Controller.text!="") {
                              verify_Ceredentials();
                            }
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.indigo),
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'Send',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
