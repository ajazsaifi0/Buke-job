import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
class ConfirmJobs extends StatefulWidget {
  String Email_Id;
  int BottomIndex;
  ConfirmJobs(this.Email_Id,this.BottomIndex);

  @override
  _ConfirmJobsState createState() => _ConfirmJobsState();
}

class _ConfirmJobsState extends State<ConfirmJobs> {
  List<String> Title=[];
  List<String> Supervisor_Names=[];
  List<String> Mobile_Nos=[];
  List<String> Work_Start_Date=[];
  List<String> Work_End_Date=[];
  List<String> Cost_Per_Hour=[];
  List<String> Location=[];
  List<String> Type=[];
  List<String> Holiday=[];
  List<String> Description=[];
  List<String> C_Email_ID=[];
  LeaveWork(int i) async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var requestBody={
      "U_Email_Id":widget.Email_Id,
      "Mobile_No":Mobile_Nos[i],
      "Title":Title[i]
    };
    try {
      var response = await http.post(
          Uri.parse("https://Bufework.com/Api/object/Delete.php"),
          headers: <String, String>{'authorization': basicAuth},
          body: json.encode(requestBody));
      dynamic res = json.decode(response.body.toString());
      if (response.statusCode == 200) {
        print(res);
        Fluttertoast.showToast(msg: res["message"]);

      }
    }catch(e){
      Fluttertoast.showToast(msg: "Done");
    }
  }
  getJobDetails() async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
try {
  var requestBody={
    "U_Email_Id":widget.Email_Id
  };
  var response = await http.post(Uri.parse("https://Bufework.com/Api/object/Accept_Data.php"),
    headers: <String, String>{'authorization': basicAuth},
  body: json.encode(requestBody));
  dynamic res = json.decode(response.body.toString());
  //final res= await json.decode(json.encode(response.body.toString()));
  if (response.statusCode == 200) {
    print(res);
    print(res["body"].length);
    //print();
    if (res["body"][0]["status"] == true) {
      for (int i = 0; i < res["body"].length; i++) {
        setState(() {
          Title.add(res["body"][i]["Title"]);
          Supervisor_Names.add(res["body"][i]["Supervisor_Name"]);
          Mobile_Nos.add(res["body"][i]["Mobile_No"]);
          Work_Start_Date.add(res["body"][i]["Work_Start_Date"]);
          Work_End_Date.add(res["body"][i]["Work_End_Date"]);
          Cost_Per_Hour.add(res["body"][i]["Cost_Per_Hour"]);
          Location.add(res["body"][i]["Location"]);
          Type.add(res["body"][i]["Type"]);
          Holiday.add(res["body"][i]["Holiday"]);
          Description.add(res["body"][i][ "Description"]);
          C_Email_ID.add(res["body"][i]["Email_Id"]);
        });
      }
      print(Title);
      print(Supervisor_Names);
      print(Mobile_Nos);
      print(Work_Start_Date);
      print(Work_End_Date);
      print(Cost_Per_Hour);
      print(Location);
    } else {
      Fluttertoast.showToast(
          msg: res["message"]);
    }
  } else {
    Fluttertoast.showToast(
        msg: "Something Goes Wrong");
  }
}catch(e){
  Fluttertoast.showToast(msg: "Something goes Wrong");
}
  }
  @override
  void initState() {
    // TODO: implement initState
    getJobDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return widget.BottomIndex==1?Title!=[]?ListView.builder(
        shrinkWrap: true,
        itemCount: Title.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 120,
            child: Card(
              elevation: 3,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Title[index],
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Accepted",
                          style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Location:"+Location[index]),
                        Text("Supervisor name:"+Supervisor_Names[index])
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cost Per day:"+Cost_Per_Hour[index]),
                        Text("Mobile No:"+Mobile_Nos[index])
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }):Column(
      mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You dont have a job yet Please surf through our app"),
          ],
        ):
    ListView.builder(
        shrinkWrap: true,
        itemCount: Title.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 240,
            child: Card(
              elevation: 3,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Title[index],
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(child: Icon(Icons.message),onTap:() async{
                          dynamic uri = 'sms:'+Mobile_Nos[index]+'?body=Welcome';
                          if (await canLaunch(uri)) {
                            await launch(uri);
                          } else {
                            // iOS
                            dynamic uri = 'sms:'+Mobile_Nos[index]+'?body=Welcome';
                            if (await canLaunch(uri)) {
                              await launch(uri);
                            } else {
                              throw 'Could not launch $uri';
                            }
                          }
                        })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [Text(Supervisor_Names[index]+"("+Type[index]+")")],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cost Per day:"+Cost_Per_Hour[index]),
                        Text("Deadline:"+Work_End_Date[index].substring(0,10))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Start Date:"+Work_Start_Date[index].substring(0,10)),
                        Text("End date:"+Work_End_Date[index].substring(0,10))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Description:"+Description[index]),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.red,
                          child: TextButton(
                              onPressed: () {
                                LeaveWork(index);
                              },
                              child: Text(
                                "Leave Work",
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
