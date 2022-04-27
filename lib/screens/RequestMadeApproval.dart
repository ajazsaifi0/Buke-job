import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobs_ui/screens/AddEmployee.dart';
import 'package:jobs_ui/screens/AttendanceSheet.dart';
import 'package:jobs_ui/screens/PaymentScreen.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';
class RequestMadeApproval extends StatefulWidget {
  String Email_Id;
  int BottomNavigation;
  String Type;
  String Name;
  RequestMadeApproval(this.Email_Id,this.BottomNavigation,this.Type,this.Name);

  @override
  _RequestMadeApprovalState createState() => _RequestMadeApprovalState();
}

class _RequestMadeApprovalState extends State<RequestMadeApproval> {
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
  List<String> Name=[];
  List<String> Prefferd_Worker=[];
  List<String> U_Email_Id=[];
  List<String> Names=[];
  List<String> Categories=[];
  List<List<String>> Agent_Names=[];
 List<String> Agent_Name=[];
  List<List<String>> Agent_Categories=[];
  List<String> Agent_Category=[];
  List<List<String>> Employee_Names=[];
  List<String> Employee_Name=[];
  List<List<String>> Employee_Categories=[];
  List<String> Employee_Category=[];
  List<List<String>> Employee_gmails=[];
  List<String> Employee_gmail=[];
  TextEditingController Sender_Email=new TextEditingController();
  LeaveWork(int i) async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var requestBody={
    "U_Email_Id":U_Email_Id[i],
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
  AcceptwithAgent(int i) async{

    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var requestBody={
      "U_Email_Id":U_Email_Id[i],
      "Email_Id":Sender_Email.text,
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
      "Prefferd_Work":Prefferd_Worker[i],
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
  getJobDetails() async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    try {
      var requestBody={
        "Email_Id":widget.Email_Id
      };
      var response = await http.post(Uri.parse("https://Bufework.com/Api/object/Accept_Data2.php"),
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
              Name.add(res["body"][i]["Name"]);
              Prefferd_Worker.add(res["body"][i]["Prefferd_Work"]);
              U_Email_Id.add(res["body"][i]["U_Email_Id"]);
              Employee_Name=Name[i].split("'");
              Employee_gmail=U_Email_Id[i].split("'");
              Employee_Category=Prefferd_Worker[i].split("'");
              Employee_Names.add(Employee_Name);
              Employee_gmails.add(Employee_gmail);
              Employee_Categories.add(Employee_Category);

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
  Accept(int i) async {
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var requestBody={
      "U_Email_Id":U_Email_Id[i],
      "Email_Id":Sender_Email.text,
      "Name":widget.Name,
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
      "Prefferd_Work":Prefferd_Worker[i]
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
  void initState() {
    // TODO: implement initState
   widget.Type!="Agent"? getJobDetails():getAgentJobDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return widget.BottomNavigation==1?ListView.builder(
        shrinkWrap: true,
        itemCount: Title.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 185,
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
                              color: Colors.indigo,
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
                        Text(widget.Type!="Agent"?Name[index]+"("+Prefferd_Worker[index]+")":Agent_Names[index].toString()+"("+Agent_Categories[index].toString()+")"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // mainAxisAlignment:
                      //MainAxisAlignment.spaceBetween,
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
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.red,
                          child: TextButton(
                            child: Text(
                              "Reject",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              LeaveWork(index);
                              Fluttertoast.showToast(msg: "Leaved");
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }):
    SingleChildScrollView(
      child: Column(
        children: [
         widget.Type!="Agent"? Padding(
            padding: const EdgeInsets.all(8.0),
            child: ToggleSwitch(
              minHeight: 50,
              minWidth: 150,
              initialLabelIndex: initialIndex,
              totalSwitches: 2,
              changeOnTap: true,
              labels: ['Employee', 'Agent'],
              onToggle: (index) {
                index==0?getJobDetails():getAgentJobDetails();
                setState(() {
                  initialIndex=index!;
                  Title=[];
                  Supervisor_Names=[];
                  Mobile_Nos=[];
                  Work_Start_Date=[];
                  Work_End_Date=[];
                  Cost_Per_Hour=[];
                  Location=[];
                  Prefferd_Worker=[];
                 // E_Email_Id=[];
                  //E_Name=[];
                  Description=[];
                  Holiday=[];
                  Type=[];
                  C_Email_ID=[];
                  U_Email_Id=[];
                  //Prefferd_Work=[];
                  Names=[];
                  Categories=[];
                  print(index);
                });
              },
            ),
          ):Container(),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: Title.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 280,
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Title[index],
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(child: Icon(Icons.share),onTap: (){
                                    setState(() {
                                      Sender_Email.text="";
                                    });
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Column(
                                            children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                              child: TextField(
                                            controller: Sender_Email,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Enter the Email Address Of the Employer',
                                              ),
                                              onChanged: (text) {
                                                setState(() {
                                                  //fullName = text;
                                                  //you can access nameController in its scope to get
                                                  // the value of text entered as shown below
                                                  //fullName = nameController.text;
                                                });
                                              },
                                          ),
                                            ),
                                              ElevatedButton(onPressed: (){
                                                Sender_Email.text!=""?
                                                initialIndex==0?
                                                    Accept(index):
                                                    AcceptwithAgent(index):
                                                    Fluttertoast.showToast(msg: "Please enter something in the textfield");
                                              }, child:Text("Send Job Data"))
                                            ],
                                          );
                                        });
                                  },),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: GestureDetector(
                                      onTap: () async{
                                        dynamic uri = 'sms:'+"+91"+Mobile_Nos[index];
                                        if (await canLaunch(uri)) {
                                          await launch(uri);
                                        } else {
                                          // iOS
                                          dynamic uri = 'sms:'+"+91"+Mobile_Nos[index]+'?body=Welcome';
                                          if (await canLaunch(uri)) {
                                            await launch(uri);
                                          } else {
                                            throw 'Could not launch $uri';
                                          }
                                        }
                                      },
                                        child: Icon(Icons.message)
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [widget.Type!="Agent"?initialIndex==0?Text(""):Text(widget.Type!="Agent"?"Agent Id: "+U_Email_Id[index]:"Employer Id: "+C_Email_ID[index]):Text(widget.Type!="Agent"?"Agent Id: "+U_Email_Id[index]:"Employer Id: "+C_Email_ID[index])],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cost Per Day:"+Cost_Per_Hour[index]),
                              Text("Location:"+Location[index])
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Start Date:"+Work_Start_Date[index].substring(0,10)),
                              Text("End Date:"+Work_End_Date[index].substring(0,10))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:Border.all(
                                      color: Colors.red,  // red as border color
                                    ),
                                  ),
                                  //color: Colors.red,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Icon(Icons.cancel,color: Colors.red,),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            LeaveWork(index);
                                            Fluttertoast.showToast(msg: "Leaved");
                                          },
                                          child: Text(
                                            "Leave Work",
                                            style: TextStyle(color: Colors.black,fontSize: 15),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                             //for deleting employees
                             Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:Border.all(
                                      color: Colors.blue,  // red as border color
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Icon(Icons.list,color: Colors.green,),
                                      ),
                                    widget.Type!="Agent"?initialIndex==0?  TextButton(
                                          onPressed: () {
                                           // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEmployee(widget.Email_Id,Title[index],Supervisor_Names[index],Mobile_Nos[index],Location[index],Description[index],Cost_Per_Hour[index],Holiday[index],Work_Start_Date[index],Work_End_Date[index],Type[index])));
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
                                                              itemCount: Employee_Names[Title.indexOf(Title[index])].length,
                                                              itemBuilder: (BuildContext context,int i) {
                                                                return
                                                                Card(
                                                                  elevation: 5,
                                                                  child: ListTile(
                                                                    title: Text(
                                                                        Employee_Names[Title.indexOf(Title[index])][i]
                                                                            .toString()),
                                                                    subtitle: Text(Employee_Categories[Title.indexOf(Title[index])][i].toString()),
                                                                    trailing: ElevatedButton(
                                                                      onPressed: (){
                                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Attendance(Employee_Names[Title.indexOf(Title[index])][i], Employee_gmails[Title.indexOf(Title[index])][i], widget.Email_Id, Title[index],"Employee",Employee_Categories[Title.indexOf(Title[index])][i])));
                                                                      },
                                                                      child: Text("Mark Attendance"),
                                                                    ),
                                                                    //subtitle: Text(Agent_Categories[index]),
                                                                  ),
                                                                );
                                                              }
                                                            )

                                                      ],
                                                    ),
                                                  );
                                                }
                                            );
                                          },
                                          child: Text(
                                            "Show Employees",
                                            style: TextStyle(color: Colors.black,fontSize: 15),
                                          )):
                                    TextButton(
                                        onPressed: () {
                                       //   Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEmployee(widget.Email_Id,Title[index],Supervisor_Names[index],Mobile_Nos[index],Location[index],Description[index],Cost_Per_Hour[index],Holiday[index],Work_Start_Date[index],Work_End_Date[index],Type[index])));
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
                                                          itemCount: Agent_Names[Title.indexOf(Title[index])].length,
                                                          itemBuilder: (BuildContext context,int i) {
                                                            return
                                                              Card(
                                                                elevation: 5,
                                                                child: ListTile(
                                                                  title: Text(
                                                                      Agent_Names[Title.indexOf(Title[index])][i]
                                                                          .toString()),
                                                                  //subtitle: Text(Agent_Categories[index]),
                                                                  subtitle: Text(
                                                                      Agent_Categories[Title.indexOf(Title[index])][i]
                                                                          .toString()),
                                                                ),
                                                              );
                                                          }
                                                      )

                                                    ],
                                                  ),
                                                );
                                              }
                                          );
                                        },
                                        child: Text(
                                          "Show Employees",
                                          style: TextStyle(color: Colors.black,fontSize: 15),
                                        ))
                                        : TextButton(
                                        onPressed: () {
                                          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEmployee(widget.Email_Id,Title[index],Supervisor_Names[index],Mobile_Nos[index],Location[index],Description[index],Cost_Per_Hour[index],Holiday[index],Work_Start_Date[index],Work_End_Date[index],Type[index])));
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
                                                          shrinkWrap: true,
                                                          itemCount: Agent_Names[Title.indexOf(Title[index])].length,
                                                          itemBuilder: (BuildContext context,int i) {
                                                            return
                                                              Card(
                                                                elevation: 5,
                                                                child: ListTile(
                                                                  title: Text(
                                                                      Agent_Names[Title.indexOf(Title[index])][i]
                                                                          .toString()),
                                                                  //subtitle: Text(Agent_Categories[index]),
                                                                  subtitle: Text(
                                                                      Agent_Categories[Title.indexOf(Title[index])][i]
                                                                          .toString()),
                                                                ),
                                                              );
                                                          }
                                                      )

                                                    ],
                                                  ),
                                                );
                                              }
                                          );
                                        },
                                        child: Text(
                                          "Show Employees",
                                          style: TextStyle(color: Colors.black,fontSize: 15),
                                        ))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        //deleting employees
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: initialIndex==1?MainAxisAlignment.spaceEvenly:MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:Border.all(
                                      color: Colors.red,  // red as border color
                                    ),
                                  ),
                                  child: TextButton(
                                      onPressed: () {
                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEmployee(widget.Email_Id,Title[index],Supervisor_Names[index],Mobile_Nos[index],Location[index],Description[index],Cost_Per_Hour[index],Holiday[index],Work_Start_Date[index],Work_End_Date[index],Type[index])));
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
                                                        itemCount: Employee_Names[Title.indexOf(Title[index])].length,
                                                        itemBuilder: (BuildContext context,int i) {
                                                          return
                                                            Card(
                                                              elevation: 5,
                                                              child: ListTile(
                                                                title: Text(
                                                                    Employee_Names[Title.indexOf(Title[index])][i]
                                                                        .toString()),
                                                                subtitle: Text(Employee_Categories[Title.indexOf(Title[index])][i].toString()),
                                                                trailing: ElevatedButton(
                                                                  onPressed: () async {
                                                                    String username = 'Bufe_Work';
                                                                    String password = 'Bufe_Work@123';
                                                                    String basicAuth =
                                                                        'Basic '+ base64Encode(utf8.encode('$username:$password'));
                                                                    print(basicAuth);
                                                                    var request_body={

                                                                      "U_Email_Id":Employee_gmails[Title.indexOf(Title[index])][i],
                                                                      // "Prefferd_Work":Employee_Categories[Title.indexOf(Title[index])].join("'"),
                                                                      "Title":Title[index],
                                                                      "Email_Id":widget.Email_Id
                                                                    };
                                                                    var response = await http.post(Uri.parse(
                                                                        "https://Bufework.com/Api/object/Delete3.php"),
                                                                        headers: <String, String>{'authorization': basicAuth},body: json.encode(request_body));
                                                                    dynamic res = json.decode(response.body);

                                                                    //final res= await json.decode(json.encode(response.body.toString()));
                                                                    if (response.statusCode == 200) {
                                                                      print(res);


                                                                      //print(res["body"].length);
                                                                      //print();

                                                                       // Fluttertoast.showToast(msg: res["message"]);
                                                                        setState(() {
                                                                          Employee_Names[Title.indexOf(Title[index])].removeAt(i);
                                                                          Employee_Categories[Title.indexOf(Title[index])].removeAt(i);
                                                                          Employee_gmails[Title.indexOf(Title[index])].removeAt(i);
                                                                          print(Employee_Names);
                                                                          print(Employee_Categories);
                                                                          print(Employee_gmails);
                                                                        });

                                                                        try {
                                                                          var request_body={
                                                                            "Name":Employee_Names[Title.indexOf(Title[index])].join("'"),
                                                                            "U_Email_Id":Employee_gmails[Title.indexOf(Title[index])].join("'"),
                                                                            "Prefferd_Work":Employee_Categories[Title.indexOf(Title[index])].join("'"),
                                                                            "Title":Title[index],
                                                                            "Email_Id":widget.Email_Id
                                                                          };
                                                                          var response = await http.post(Uri.parse(
                                                                              "https://Bufework.com/Api/object/Delete2.php"),
                                                                              headers: <String, String>{'authorization': basicAuth},body: json.encode(request_body));
                                                                          dynamic res = json.decode(response.body);

                                                                          //final res= await json.decode(json.encode(response.body.toString()));
                                                                          if (response.statusCode == 200) {
                                                                            //print(res);
                                                                            //delete from employee table
                                                                            Fluttertoast.showToast(msg: res["message"]);

                                                                          } else {
                                                                            Fluttertoast.showToast(
                                                                                msg: "Something Goes Wrong");
                                                                          }
                                                                        }catch(e){
                                                                          print(e);
                                                                          Fluttertoast.showToast(
                                                                              msg: "Something Goes Wrong");
                                                                        }


                                                                    } else {
                                                                      Fluttertoast.showToast(
                                                                          msg: "Something Goes Wrong");
                                                                    }

                                                                    //print(res["body"].length);
                                                                    //print();




                                                                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>Attendance(Employee_Names[Title.indexOf(Title[index])][i], Employee_gmails[Title.indexOf(Title[index])][i], widget.Email_Id, Title[index],"Employee",Employee_Categories[Title.indexOf(Title[index])][i])));

                                                                //  DeleteEmployees();
                                                                  },
                                                                  child: Text("Remove Employee"),
                                                                ),
                                                                //subtitle: Text(Agent_Categories[index]),
                                                              ),
                                                            );
                                                        }
                                                    )

                                                  ],
                                                ),
                                              );
                                            }
                                        );
                                      },
                                      child: Text(
                                        "Delete Employees",
                                        style: TextStyle(color: Colors.black,fontSize: 15),
                                      )),
                                ),
                              ),
                              widget.Type.contains("Employer")?Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(

                                  decoration: BoxDecoration(
                                    border:Border.all(
                                      color: Colors.pinkAccent,  // red as border color
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Icon(initialIndex==0?Icons.add:Icons.monetization_on,color: Colors.pinkAccent,),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            initialIndex==0?
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEmployee(widget.Email_Id,Title[index],Supervisor_Names[index],Mobile_Nos[index],Location[index],Description[index],Cost_Per_Hour[index],Holiday[index],Work_Start_Date[index],Work_End_Date[index],Type[index])))
                                                :Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentScreen(widget.Email_Id,U_Email_Id[index])));
                                          },
                                          child: Text(
                                            initialIndex==0?"Add Employee":"Pay Amount",
                                            style: TextStyle(color: Colors.black,fontSize: 15),
                                          )),
                                    ],
                                  ),
                                ),
                              ):Container(),
                              widget.Type.contains("Employer")?Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border:Border.all(
                                      color: Colors.indigo,
                                     // red as border color
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child:initialIndex==1? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Icon(Icons.person,color: Colors.indigo,),
                                      ),
                                     TextButton(
                                          onPressed: () {
                                           initialIndex==0? Navigator.push(context, MaterialPageRoute(builder: (context)=>Attendance(Name[index], C_Email_ID[index], widget.Email_Id, Title[index],"Employee",Prefferd_Worker[index]))):
                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>Attendance(Names[index], C_Email_ID[index], widget.Email_Id, Title[index],"Agent",Categories[index])));
                                          },
                                          child: Text(
                                            "Mark Attendence",
                                            style: TextStyle(color: Colors.black,fontSize: 15),
                                          ))
                                    ],
                                  ):Container()
                                ),
                              ):
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border:Border.all(
                                      color: Colors.indigo,
                                      // red as border color
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Icon(Icons.person,color: Colors.indigo,),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                           // initialIndex==0? Navigator.push(context, MaterialPageRoute(builder: (context)=>Attendance(Name[index], C_Email_ID[index], widget.Email_Id, Title[index],"Employee",Prefferd_Worker[index]))):
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Attendance(Names[index], C_Email_ID[index], widget.Email_Id, Title[index],"Agent",Categories[index])));
                                          },
                                          child: Text(
                                            "Mark Attendence",
                                            style: TextStyle(color: Colors.black,fontSize: 15),
                                          )),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
 DeleteEmployee() async{

  }
  getAgentJobDetails() async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    try {
      var request_body={
        widget.Type=="Agent"?"U_Email_Id":"Email_Id":widget.Email_Id
      };
      var response = await http.post(Uri.parse(
          "https://Bufework.com/Api/object/Agent_Accept_Data.php"),
        headers: <String, String>{'authorization': basicAuth},body: json.encode(request_body));
      dynamic res = json.decode(response.body);

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
              Prefferd_Worker.add(res["body"][i]["Prefferd_Work"]);
              U_Email_Id.add(res["body"][i]["U_Email_Id"]);
              //  E_Name.add(res["body"][i]["Name"]);
              Description.add(res["body"][i]["Description"]);
              Holiday.add(res["body"][i]["Holiday"]);
              Type.add(res["body"][i]["Type"]);
              C_Email_ID.add(res["body"][i]["Email_Id"]);
              Names.add(res["body"][i]["Names"]);
              Agent_Name=Names[i].split(',');
              Categories.add(res["body"][i]["Category"]);
              Agent_Category=Categories[i].split(',');
              Agent_Names.add(Agent_Name);
              Agent_Categories.add(Agent_Category);
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
      print(e);
      Fluttertoast.showToast(
          msg: "Something Goes Wrong");
    }
  }

}
