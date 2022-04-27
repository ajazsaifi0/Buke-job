import 'dart:convert';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class AgentRequestScreen extends StatefulWidget {
 String Email_Id;
 String Name;
 AgentRequestScreen(this.Email_Id,this.Name);

  @override
  _AgentRequestScreenState createState() => _AgentRequestScreenState();
}

class _AgentRequestScreenState extends State<AgentRequestScreen> {
  List<String> Title=[];
  List<String> Supervisor_Names=[];
  List<String> Mobile_Nos=[];
  List<String> Work_Start_Date=[];
  List<String> Work_End_Date=[];
  List<String> Cost_Per_Hour=[];
  List<String> Location=[];
  List<String> Preffered_Work=[];
  List<dynamic> E_Email_Id=[];
  List<String> E_Name=[];
  List<String> Description=[];
  List<String> Holiday=[];
  List<String> Type=[];
  List<String> C_Email_ID=[];
  List<String> Prefferd_Work=[];
  List<String> Names=[];
  List<String> Categories=[];
  List<String> Agent_Names=[];
  List<String> Agent_Categories=[];
  getData() async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    try {
      var response = await http.post(Uri.parse(
          "https://Bufework.com/Api/object/User_Apply.php?Email_Id=" +
              widget.Email_Id),
        headers: <String, String>{'authorization': basicAuth},);
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
              Preffered_Work.add(res["body"][i]["Prefferd_Work"]);
              E_Email_Id.add(res["body"][i]["U_Email_Id"]);
              E_Name.add(res["body"][i]["Name"]);
              Description.add(res["body"][i][ "Description"]);
              Holiday.add(res["body"][i]["Holiday"]);
              Type.add(res["body"][i]["Type"]);
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
      Fluttertoast.showToast(
          msg: "Something Goes Wrong");
    }
  }
  getAgentData() async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    try {
      var response = await http.post(Uri.parse(
          "https://Bufework.com/Api/object/Agent_Data.php?Email_Id=" +
              widget.Email_Id),
        headers: <String, String>{'authorization': basicAuth},);
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
              Preffered_Work.add(res["body"][i]["Prefferd_Work"]);
              E_Email_Id.add(res["body"][i]["U_Email_Id"]);
            //  E_Name.add(res["body"][i]["Name"]);
              Description.add(res["body"][i]["Description"]);
              Holiday.add(res["body"][i]["Holiday"]);
              Type.add(res["body"][i]["Type"]);
              C_Email_ID.add(widget.Email_Id);
              Names.add(res["body"][i]["Names"]);
              Agent_Names=Names[i].split(',');
              Categories.add(res["body"][i]["Category"]);
              Agent_Categories=Categories[i].split(',');
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
      Fluttertoast.showToast(
          msg: "Something Goes Wrong");
    }
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }
  Accept(int i) async {
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var requestBody={
      "U_Email_Id":E_Email_Id[i],
      "Email_Id":C_Email_ID[i],
      "Name":E_Name[i],
      "Type":Type[i],
      "Title":Title[i],
      "Supervisor_Name":Supervisor_Names[i],
      "Mobile_No":Mobile_Nos[i],
      "Location":Location[i],
      "Description":Description[i],
      "Cost_Per_Hour":Cost_Per_Hour[i],
      "Holiday":Holiday[i],
      "Work_Start_Date":Work_Start_Date[i],
      "Work_End_Date":Work_End_Date[i],
      "Prefferd_Work":Preffered_Work[i]
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
      "U_Email_Id":E_Email_Id[i],
      "Email_Id":C_Email_ID[i],
      "Name":E_Name[i],
      "Type":Type[i],
      "Title":Title[i],
      "Supervisor_Name":Supervisor_Names[i],
      "Mobile_No":Mobile_Nos[i],
      "Location":Location[i],
      "Description":Description[i],
      "Cost_Per_Hour":Cost_Per_Hour[i],
      "Holiday":Holiday[i],
      "Work_Start_Date":Work_Start_Date[i],
      "Work_End_Date":Work_End_Date[i],
      "Prefferd_Work":Preffered_Work[i]
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
  int initialIndex=0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ToggleSwitch(
              minHeight: 50,
              minWidth: 150,
              initialLabelIndex: initialIndex,
              totalSwitches: 2,
              changeOnTap: true,
              labels: ['Employee', 'Agent'],
              onToggle: (index) {
                index==1?getAgentData():getData();
              setState(() {
                initialIndex=index!;
                Title=[];
                 Supervisor_Names=[];
                 Mobile_Nos=[];
                 Work_Start_Date=[];
             Work_End_Date=[];
                Cost_Per_Hour=[];
                Location=[];
                Preffered_Work=[];
                 E_Email_Id=[];
               E_Name=[];
                Description=[];
                Holiday=[];
                 Type=[];
                 C_Email_ID=[];
                 Prefferd_Work=[];
                Names=[];
                 Categories=[];
                print(index);
              });
              },
            ),
          ),
         initialIndex==0? ListView.builder(
           physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: Title.length,
              //Title.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                 // height: 240,
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
                                // Title[index],
                                Title[index],
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              FittedBox(child: Text("Requester ID:"+E_Email_Id[index]//+Mobile_Nos[index])
                              ),),


                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Requested By:"+E_Name[index]),

                              // FittedBox(child: Text("Location of Work: "//+Location[index])
                              // ),)

                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Name of Supervisor: "+Supervisor_Names[index]
                              ),
                              // Text("Cost Per Day:₹"//+Cost_Per_Hour[index]
                              // ),
                              // Text("Holidays:")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Start date:"+
                                  Work_Start_Date[index].substring(0,10)
                              ),
                              Text("End date:"+Work_End_Date[index].substring(0,10)
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                color: Colors.red,
                                child: TextButton(
                                    onPressed: () {
                                      //  Apply(index);
                                      Fluttertoast.showToast(msg: "Rejected");

                                    },
                                    child: Text(
                                      "Reject",
                                      style: TextStyle(
                                          color: Colors.white),
                                    )),
                              ),
                              Container(
                                color: Colors.blue,
                                child: TextButton(
                                    onPressed: () {
                                      //  Apply(index);
                                      Accept(index);
                                    },
                                    child: Text(
                                      "Accept",
                                      style: TextStyle(
                                          color: Colors.white),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }):ListView.builder(
           physics: NeverScrollableScrollPhysics(),
             shrinkWrap: true,
             itemCount: Title.length,
             //Title.length,
             itemBuilder: (BuildContext context, int index) {
               return Container(
                 height: 300,
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
                               // Title[index],
                               Title[index],
                               style: TextStyle(
                                   fontSize: 18,
                                   fontWeight: FontWeight.bold),
                             ),
                           ],
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           mainAxisAlignment:
                           MainAxisAlignment.spaceBetween,
                           children: [
                             FittedBox(child: Text("Requester ID:"+E_Email_Id[index]//+Mobile_Nos[index])
                             ),),


                           ],
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           mainAxisAlignment:
                           MainAxisAlignment.spaceBetween,
                           children: [
                            // Text("Requested By:"+E_Name[index]),

                             // FittedBox(child: Text("Location of Work: "//+Location[index])
                             // ),)

                           ],
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           mainAxisAlignment:
                           MainAxisAlignment.spaceBetween,
                           children: [
                             Text("Name of Supervisor: "+Supervisor_Names[index]
                             ),
                             // Text("Cost Per Day:₹"//+Cost_Per_Hour[index]
                             // ),
                             // Text("Holidays:")
                           ],
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           mainAxisAlignment:
                           MainAxisAlignment.spaceBetween,
                           children: [
                             Text("Start date:"+
                                 Work_Start_Date[index].substring(0,10)
                             ),
                             Text("End date:"+Work_End_Date[index].substring(0,10)
                             )
                           ],
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           mainAxisAlignment:
                           MainAxisAlignment.spaceEvenly,
                           children: [
                             Container(
                               color: Colors.red,
                               child: TextButton(
                                   onPressed: () {
                                     //  Apply(index);
                                     Fluttertoast.showToast(msg: "Rejected");

                                   },
                                   child: Text(
                                     "Reject",
                                     style: TextStyle(
                                         color: Colors.white),
                                   )),
                             ),
                             Container(
                               color: Colors.blue,
                               child: TextButton(
                                   onPressed: () {
                                     //  Apply(index);
                                    // Accept(index);
                                     AcceptwithAgent(index);
                                   },
                                   child: Text(
                                     "Accept",
                                     style: TextStyle(
                                         color: Colors.white),
                                   )),
                             )
                           ],
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           mainAxisAlignment:
                           MainAxisAlignment.spaceEvenly,
                           children: [
                             Container(
                               color: Colors.green,
                               child: TextButton(
                                   onPressed: () {
                                     //  Apply(index);
                                    // Accept(index);
                                     showModalBottomSheet(
                                         context: context,
                                         builder: (builder){
                                           return SingleChildScrollView(
                                             child: Column(
                                               children: [
                                                 Padding(
                                                   padding: const EdgeInsets.all(8.0),
                                                   child: Text("Employee Details",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                                                 ),
                                                 ListView.builder(
                                                   physics: NeverScrollableScrollPhysics(),
                                                   shrinkWrap: true,
                                                   itemCount: Agent_Names.length,
                                                   itemBuilder: (BuildContext context,int index){
                                                     return Card(
                                                       elevation: 5,
                                                       child: ListTile(
                                                         title: Text(Agent_Names[index]),
                                                         subtitle: Text(Agent_Categories[index]),
                                                       ),
                                                     );
                                                   },)
                                               ],
                                             ),
                                           );
                                         }
                                     );
                                   },
                                   child: Text(
                                     "Show Employee Details",
                                     style: TextStyle(
                                         color: Colors.white),
                                   )),
                             )
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
               );
             })
        ],
      ),
    );
  }
  AcceptwithAgent(int i) async{

      String username = 'Bufe_Work';
      String password = 'Bufe_Work@123';
      String basicAuth =
          'Basic '+ base64Encode(utf8.encode('$username:$password'));
      print(basicAuth);
      var requestBody={
        "U_Email_Id":E_Email_Id[i],
        "Email_Id":widget.Email_Id,
        "Name":widget.Name,
        "Type":"Agent",
        "Title":Title[i],
        "Supervisor_Name":Supervisor_Names[i],
        "Mobile_No":Mobile_Nos[i],
        "Location":Location[i],
        "Description":Description[i],
        "Cost_Per_Hour":Cost_Per_Hour[i],
        "Holiday":Holiday[i],
        "Work_Start_Date":Work_Start_Date[i],
        "Work_End_Date":Work_End_Date[i],
        "Prefferd_Work":Preffered_Work[i],
        "Names":Agent_Names.join(","),
        "Category":Agent_Categories.join(",")
      };
      String url =
          "https://Bufework.com/Api/object/Agent_Accept.php";
      var response = await http.post(Uri.parse(url),
          headers: <String, String>{'authorization': basicAuth},body: json.encode(requestBody));
      var res=json.decode(response.body);
      if(response.statusCode==200){
        Fluttertoast.showToast(msg: res["message"]);
      }else{
        Fluttertoast.showToast(msg: "Something Goes Wrong");
      }
    }

}
