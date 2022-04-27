import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:jobs_ui/screens/PaymentScreen.dart';
import 'package:jobs_ui/widgets/text_button.dart';

class Attendance extends StatefulWidget {
  String Name;
  String U_Email_Id;
  String Email_Id;
  String Title;
  String Type;
  String Category;
  Attendance(this.Name,this.U_Email_Id,this.Email_Id,this.Title,this.Type,this.Category);

  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  String Attendance = "present";
  List<String> date=[];
  List<String> att_Status=[];
  List<String> Agent_Names=[];
  List<String> Agent_Categories=[];
  List<String> Attendance_List=[];
  List<String> Attendance_List2=[];
  UploadAttendance()async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var requestBody={
      "Title":widget.Title,
      "Name":widget.Name,
      "Email_Id":widget.Email_Id,
      "Date":DateTime.now().toString().substring(0,10),
      "Attendance":Attendance
    };
    try {
      var response = await http.post(
          Uri.parse("https://Bufework.com/Api/object/Attendance.php"),
          headers: <String, String>{'authorization': basicAuth},
          body: json.encode(requestBody));
      dynamic res = json.decode(response.body.toString());
      if (response.statusCode == 200) {
        print(res);
        Fluttertoast.showToast(msg: res["message"]);
      }
    }catch(e){
      Fluttertoast.showToast(msg: "Something goes Wrong");
    }
  }
  getAttendance()async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var requestBody={
      "Title":widget.Title,
      "Name":widget.Name,
    };
    try {
      var response = await http.post(
          Uri.parse("https://Bufework.com/Api/object/Attendance_Data.php"),
          headers: <String, String>{'authorization': basicAuth},
          body: json.encode(requestBody));
      dynamic res = json.decode(response.body);
      print(res);
      if (response.statusCode == 200) {
        print(res);
        for(int i=0;i<res["body"].length;i++){
          setState(() {
            date.add(res["body"][i]["Date"]);
            att_Status.add(res["body"][i]["Attendance"]);
            Attendance_List=att_Status[i].split(",");
          });
        }
      }
    }catch(e){
      print(e);
      Fluttertoast.showToast(msg: "Something goes Wrong");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    getAttendance();
    widget.Type=="Agent"?
    setState(() {
          Agent_Names=widget.Name.split(",");
          Agent_Categories=widget.Category.split(",");
    }):
        null;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          widget.Type.contains("Employee")?GestureDetector(
            onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentScreen(widget.Email_Id, widget.U_Email_Id)));
            },
              child:Text("PAY",style: TextStyle(color: Colors.white),)
          ):Container()
        ],
        title: Text("Attendance for Today"),
      ),
      body: widget.Type=="Employee"?Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Text(
                "1.)"+widget.Name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropDown<String>(
                // isExpanded: true,
                items: ["present", "absent"],
                hint: Text("present"),
                icon: Icon(
                  Icons.expand_more,
                  color: Colors.indigo,
                ),
                onChanged: (value) {
                  setState(() {
                    Attendance = value!;
                  });
                },
              ),
              SizedBox()
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextButton(
              buttonName: "Update Attendance",
              onTap: () {
                UploadAttendance();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Date",style: TextStyle(fontWeight: FontWeight.bold),),
                Text("Attendance",style: TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          att_Status.length==0?Text("No Previous Attendance"):ListView.builder(
            shrinkWrap: true,
              itemCount: att_Status.length,
              itemBuilder: (BuildContext context,int index){
                return ListTile(
                    //leading: Icon(Icons.list),
                    trailing: Text(date[index],
                      style: TextStyle(
                          color: Colors.green,fontSize: 15),),
                    title:Text(att_Status[index])
                );
              }
          )
        ],
      ):SingleChildScrollView(
        child: Column(
          children: [

            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
                itemCount: Agent_Names.length,
                itemBuilder: (BuildContext context,int index){
              return ListTile(
                leading: Text((index+1).toString()+")",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                title: Text(Agent_Names[index]),
                subtitle: Text(Agent_Categories[index]),
                trailing:    DropDown<String>(
                  // isExpanded: true,
                  items: ["present", "absent"],
                  hint: Text("Select Attendance"),
                  icon: Icon(
                    Icons.expand_more,
                    color: Colors.indigo,
                  ),
                  onChanged: (value) {
                    setState(() {
                    Attendance_List2.add(value!);
                    });
                  },
                ),

              );
            }),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextButton(
                buttonName: "Update Attendance",
                onTap: () {
                  Attendance_List2.length==Agent_Names.length?
                  UploadAgentAttendance():Fluttertoast.showToast(msg: "Add Attendance for all Employees");

                },
              ),
            ),
            att_Status.length==0?Text("No Previous Attendance"):ListView.builder(
                shrinkWrap: true,
                itemCount: date.length,
                itemBuilder: (BuildContext context,int index){
                  return ListTile(
                    //leading: Icon(Icons.list),
                      trailing: Text(date[index],
                        style: TextStyle(
                            color: Colors.green,fontSize: 15),),
                      title:ListView.builder(
                        shrinkWrap: true,
                        itemCount: Agent_Names.length,
                        itemBuilder: (BuildContext context, int i) {
                         return Text(Agent_Names[i]+"("+Attendance_List[i]+")",style: TextStyle(color: Attendance_List[i].contains("present")?Colors.indigo:Colors.red),);
                      },

                      )
                  );
                }
            )
          ],
        ),
      )
    );
  }
  UploadAgentAttendance()async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var requestBody={
      "Title":widget.Title,
      "Name":Agent_Names.join(","),
      "Email_Id":widget.Email_Id,
      "Date":DateTime.now().toString().substring(0,10),
      "Attendance":Attendance_List2.join(",")
    };
    try {
      var response = await http.post(
          Uri.parse("https://Bufework.com/Api/object/Attendance.php"),
          headers: <String, String>{'authorization': basicAuth},
          body: json.encode(requestBody));
      dynamic res = json.decode(response.body.toString());
      if (response.statusCode == 200) {
        print(res);
        Fluttertoast.showToast(msg: res["message"]);
      }
    }catch(e){
      Fluttertoast.showToast(msg: "Something goes Wrong");
    }
  }
}
