import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class AddEmployee extends StatefulWidget {
  String? C_Employee;
  String?  Title;
  String?  Supervisor_Names;
  String?  Mobile_Nos;
  String?  Location;
  String?  Description;
  String?  Cost_Per_Hour;
  String?  Holiday;
  String?  Work_Start_Date;
  String?  Work_End_Date;
  String?  Type;

  AddEmployee(this.C_Employee,this.Title,this.Supervisor_Names,this.Mobile_Nos,this.Location,this.Description,this.Cost_Per_Hour,this.Holiday,this.Work_Start_Date,this.Work_End_Date,this.Type);

  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  bool isloading=true;
  List<String> Name=[];
  List<String> type=[];
  List<String> Email=[];
  getEmployeedata() async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);

    try {
      var response = await http.post(
          Uri.parse("https://Bufework.com/Api/object/Employee.php"),
          headers: <String, String>{'authorization': basicAuth},
         );
      dynamic res = json.decode(response.body.toString());
      if (response.statusCode == 200) {
        print(res);
        for(int i=0;i<res["body"].length;i++){
          setState(() {
           Name.add(res["body"][i]["Name"]);
            type.add(res["body"][i]["Type_Of_Worker"]);
            Email.add(res["body"][i]["Email_Id"]);
            // Date.add(res["body"][i]["Date"]);
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
    getEmployeedata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title:Text("Add Employee"),
        centerTitle: true,
      ),
      body:  isloading==true?Center(child: CircularProgressIndicator(backgroundColor: Colors.white,)):SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Name",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("Type",style: TextStyle(fontWeight: FontWeight.bold),),

                ],
              ),
            ),
                  Name.length==0?Text("No Employees"):ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: Name.length,
                      itemBuilder: (BuildContext context,int index){
                        return Card(elevation: 5,child:
                          Container(
                            height: 120,
                            child: Column(

                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(Name[index],style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                      ),
                                      ),
                                  Text(type[index],style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  ),
                                  )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    // mainAxisAlignment:
                                    //MainAxisAlignment.spaceBetween,
                                    children: [

                                      Row(

                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          Icon(
                                            Icons.star,
                                          )
                                        ],
                                      ),
                                      ElevatedButton(onPressed: (){
                                        AddEmp(index);
                                      }, child: Text(
                                        "Add"
                                      ))


                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        // ListTile(
                        //   onTap: (){
                        //     AddEmp(index);
                        //   },
                        //   leading: Text(Name[index]),
                        //   trailing: Text(type[index]),
                        // )
                          ,);
                      }
                  )


          ],
        ),
      ),
    );
  }
  AddEmp(int i) async {
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var requestBody={
      "U_Email_Id":Email[i],
      "Email_Id":widget.C_Employee,
      "Name":Name[i],
      "Type":widget.Type,
      "Title":widget.Title,
      "Supervisor_Name":widget.Supervisor_Names,
      "Mobile_No":widget.Mobile_Nos,
      "Location":widget.Location,
      "Description":widget.Description,
      "Cost_Per_Hour":widget.Cost_Per_Hour,
      "Holiday":widget.Holiday,
      "Work_Start_Date":widget.Work_Start_Date,
      "Work_End_Date":widget.Work_End_Date,
      "Prefferd_Work":type[i]
    };
    try {
      var response = await http.post(
          Uri.parse("https://Bufework.com/Api/object/Accept.php"),
          headers: <String, String>{'authorization': basicAuth},
          body: json.encode(requestBody));
      dynamic res = json.decode(response.body.toString());
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: res["message"]);
        if(res["message"].contains("Already")){
          Fluttertoast.showToast(msg: "already Applied");
        }else {
          Accept2(i);
        }
      } else {
        Fluttertoast.showToast(
            msg: "Something Goes Wrong");
      }
    }catch(e){
      Fluttertoast.showToast(msg: "Something Goes Wrong");
    }
  }
  Accept2(int i) async {
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var requestBody={
      "U_Email_Id":Email[i],
      "Email_Id":widget.C_Employee,
      "Name":Name[i],
      "Type":widget.Type,
      "Title":widget.Title,
      "Supervisor_Name":widget.Supervisor_Names,
      "Mobile_No":widget.Mobile_Nos,
      "Location":widget.Location,
      "Description":widget.Description,
      "Cost_Per_Hour":widget.Cost_Per_Hour,
      "Holiday":widget.Holiday,
      "Work_Start_Date":widget.Work_Start_Date,
      "Work_End_Date":widget.Work_End_Date,
      "Prefferd_Work":type[i]
    };
    try {
      var response = await http.post(
          Uri.parse("https://Bufework.com/Api/object/Accept2.php"),
          headers: <String, String>{'authorization': basicAuth},
          body: json.encode(requestBody));
      dynamic res = json.decode(response.body.toString());
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: res["message"]);
      } else {
        Fluttertoast.showToast(
            msg: "Something Goes Wrong");
      }
    }catch(e){
      Fluttertoast.showToast(msg: "Something Goes Wrong");
    }
  }
}
