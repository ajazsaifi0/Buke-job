import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ProfileUpdateForm extends StatefulWidget {
  String? Name;
  String? Address;
  String? Email_Id;
 ProfileUpdateForm(this.Name,this.Address,this.Email_Id);

  @override
  _ProfileUpdateFormState createState() => _ProfileUpdateFormState();
}

class _ProfileUpdateFormState extends State<ProfileUpdateForm> {
  TextEditingController NameController=new TextEditingController();
  TextEditingController AddressController=new TextEditingController();
  UpdateDetails()async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var reqBody={
    "Email_Id":widget.Email_Id,
      "Name":NameController.text,
      "Address":AddressController.text
    };

    var response=await http.post(Uri.parse("https://Bufework.com/Api/object/Update_Profile.php"),headers: <String, String>{'authorization': basicAuth},body: json.encode(reqBody));
    var res=json.decode(response.body);
    if(response.statusCode==200){
      if(res["status"]==true){
        Fluttertoast.showToast(msg: res["message"]);
        Navigator.pop(context);
      }
    }else{
      Fluttertoast.showToast(
          msg: "Something Goes Wrong");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      NameController.text=widget.Name!;
      AddressController.text=widget.Address!;
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Details"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: TextField (
          controller: NameController,
        decoration: InputDecoration(
        border: InputBorder.none,
            labelText: 'Enter Name',
            hintText: 'Enter Your Name'
        ),
    ),
      ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField (
        controller: AddressController,
      decoration: InputDecoration(
      border: InputBorder.none,
      labelText: 'Enter Address',
      hintText: 'Enter Address'
      ),
      ),
    ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo, // background
                onPrimary: Colors.indigo, // foreground
              ),
              onPressed: (){
                if(NameController.text!=null&&AddressController.text!=null) {
                  UpdateDetails();
                }
              }, child: Text("Submit",style: TextStyle(color: Colors.white),))
    ],
      ),
    );
  }
}
