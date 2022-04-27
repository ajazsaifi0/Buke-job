import 'dart:convert';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobs_ui/screens/account.dart';
import 'package:jobs_ui/screens/agent.dart';
import 'package:jobs_ui/screens/employee.dart';
import 'package:jobs_ui/screens/employer.dart';
import 'package:jobs_ui/screens/language.dart';
import 'package:jobs_ui/utlis/constants.dart';

import 'Helper Function/SF.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp( FirebasePhoneAuthProvider(
    child: MaterialApp(
        home:MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool firstTime = true;
  bool isLoggedIn = false;
  bool isLoading = true;
  String UserName = "";
  String Password="";
  verify_Ceredentials(String Email,String SFPassword) async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);

    var response=await http.post(Uri.parse("https://Bufework.com/Api/object/Login.php?Email_Id="+Email+"&Password="+Password),headers: <String, String>{'authorization': basicAuth});
    var res=json.decode(response.body);
    if(response.statusCode==200){
      if(res["status"]==true) {

        setState(() {
          isLoading = false;
          KEmail_Id=Email;
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
            Fluttertoast.showToast(
                msg: "Something goes Wrong");
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
  getloggedInState() async {
    var LoginState = await HelperFunctions.getUserLoggedInState();
    setState(() {
      if (LoginState != null) {
        isLoggedIn = LoginState;
        if (isLoggedIn == true) {
          getUsername();
        }
        isLoading = false;
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }
  getUsername() async {
    var number = await HelperFunctions.getUserNameFromSharedPrefrence();
    var Pass=await HelperFunctions.getPassword();
    // var address = await HelperFunctions.getAddress();
    // var locality = await HelperFunctions.getLocality();
    // print(locality);
    // print(address);

    setState(() {
      if (number != null&&Pass!=null) {
        UserName = number;
        Password=Pass;
        // Address = address!;
        // Locality = locality!;

      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
    try{
      verify_Ceredentials(UserName, Password);
    }catch(e){
      print(e);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    getloggedInState();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/images/launch.png"), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo
      ),
      home: isLoading == false?isLoggedIn==false?const Account():Center(child: CircularProgressIndicator(color: Colors.white,)):Center(child: CircularProgressIndicator(color: Colors.white,)),
    );
  }
}
