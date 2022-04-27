import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jobs_ui/screens/Category.dart';
class EmployeeDataForAgent extends StatefulWidget {


  @override
  _EmployeeDataForAgentState createState() => _EmployeeDataForAgentState();
}

class _EmployeeDataForAgentState extends State<EmployeeDataForAgent> {
  List<String> Name=[];
  List<String> type=[];
  List<String> Email=[];
  bool isloading=true;
  gyetEmployeedata() async{
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
    for(int i=0;i<res["bod"].length;i++){
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
        title: Text("Employee Details"),
      ),
      body:isloading==false? SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
                itemCount: Name.length,
                itemBuilder: (BuildContext context,int index){
                  return ListTile(
                      leading: Icon(Icons.list),
                      trailing: Text(type[index],
                        style: TextStyle(
                            color: Colors.green,fontSize: 15),),
                      title:Text(Name[index]),
                    subtitle: Text(Email[index]),
                  );
                }
            ),
          ],
        ),
      ):Center(child: CircularProgressIndicator(color: Colors.blue,))
    );
  }
}
