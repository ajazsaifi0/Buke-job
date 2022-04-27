import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Passbook extends StatefulWidget {
  String? Email;
  String? Type;
  Passbook(this.Email,this.Type);

  @override
  _PassbookState createState() => _PassbookState();
}

class _PassbookState extends State<Passbook> {
  bool isloading=true;
  List<String> sender_mail=[];
  List<String> reciever_mail=[];
  List<String> Amount=[];
  List<String> Date=[];
  getPassbookdata()async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var requestBody={
      widget.Type=="Employee"?"reciever_mail":"sender_mail":widget.Email
    };
    try {
      var response = await http.post(
          Uri.parse("https://Bufework.com/Api/object/Payment_data.php"),
          headers: <String, String>{'authorization': basicAuth},
          body: json.encode(requestBody));
      dynamic res = json.decode(response.body.toString());
      if (response.statusCode == 200) {
        print(res);
        for(int i=0;i<res["body"].length;i++){
          setState(() {
          sender_mail.add(res["body"][i]["sender_mail"]);
          reciever_mail.add(res["body"][i]["reciever_mail"]);
          Amount.add(res["body"][i]["Amount"]);
          Date.add(res["body"][i]["Date"]);
          });
        }
        setState(() {
          isloading=false;
        });
      }
    }catch(e){
      Fluttertoast.showToast(msg: "Something goes Wrong");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    getPassbookdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Passbook"),
        centerTitle: true,
      ),
      body: isloading==true?Center(child: CircularProgressIndicator(backgroundColor: Colors.white,)):
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Date",style: TextStyle(fontWeight: FontWeight.bold),),
                Text("Senders Mail",style: TextStyle(fontWeight: FontWeight.bold),),
                Text("Reciever Mail",style: TextStyle(fontWeight: FontWeight.bold),),
                Text("Amount",style: TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          sender_mail.length==0?Text("No Previous Transaction"):ListView.builder(
              shrinkWrap: true,
              itemCount: sender_mail.length,
              itemBuilder: (BuildContext context,int index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(Date[index].substring(0,11)+"\n"+Date[index].substring(11),style: TextStyle(),),
                      Text(sender_mail[index].substring(0,7),style: TextStyle(),),
                      Text(reciever_mail[index].substring(0,9),style: TextStyle(),),
                      Text("₹"+Amount[index],style: TextStyle(),)
                    ],
                  ),
                );
              }
          )
        ],
      ),

    );
  }
}
