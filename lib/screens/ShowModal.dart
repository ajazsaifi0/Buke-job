import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobs_ui/utlis/constants.dart';
class ShowModal extends StatefulWidget {
 final Members;
 final U_Email_Id;
 final Email_Id;
 final Name;
 final Title;
 final Supervisor_Name;
 final Mobile_No;
 final Location;
 final Description;
 final Cost_Per_Hour;
 final Holiday;
 final Work_Start_Date;
 final Work_End_Date;
 final Prefferd_Work;
 ShowModal({this.Members,this.U_Email_Id,this.Email_Id,this.Name,this.Title,this.Supervisor_Name,this.Mobile_No,this.Location,this.Description,this.Cost_Per_Hour,this.Holiday,this.Work_Start_Date,this.Work_End_Date,this.Prefferd_Work});

  @override
  _ShowModalState createState() => _ShowModalState();
}

class _ShowModalState extends State<ShowModal> {
  List<String> Names_of_Employees=[];
  List<String> Category_of_Employees=[];
  String Name_of_Employee="";
  TextEditingController add=new TextEditingController();
  List<String> Name=[];
  List<String> type=[];
  List<String> Email=[];
  List<String> SearchedData=[];
  List<String> SearchedCategory=[];
  bool isloading=true;
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
  Apply() async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var requestBody={
      "U_Email_Id":widget.U_Email_Id,
      "Email_Id":widget.Email_Id,
      "Name":widget.Name,
      "Type":"Agent",
      "Title":widget.Title,
      "Supervisor_Name":widget.Supervisor_Name,
      "Mobile_No":widget.Mobile_No,
      "Location":widget.Location,
      "Description":widget.Description,
      "Cost_Per_Hour":widget.Cost_Per_Hour,
      "Holiday":widget.Holiday,
      "Work_Start_Date":widget.Work_Start_Date,
      "Work_End_Date":widget.Work_End_Date,
      "Prefferd_Work":widget.Prefferd_Work,
      "Names":Names_of_Employees.join(","),
      "Category":Category_of_Employees.join(",")
    };
    String url =
        "https://Bufework.com/Api/object/Agent.php";
    var response = await http.post(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth},body: json.encode(requestBody));
    var res=json.decode(response.body);
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: res["message"]);
    }else{
      Fluttertoast.showToast(msg: "Something Goes Wrong");
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
    return widget.Members!=null&&widget.Members!=""?SingleChildScrollView(
      child: SafeArea(
        child: Container(
          //height: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment
                  .start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'This Job Required ' +
                            (int.parse(widget.Members)-Names_of_Employees.length).toString() +
                            " Employees",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight
                                .bold),),
                    ),
                    Names_of_Employees.length==int.parse(widget.Members)?
                    ElevatedButton(onPressed: (){
                      Apply();
                    }, child: Text("Apply")):
                    Container()
                  ],
                ),
                TextField(
                  controller: add,
                  style: kBodyText
                      .copyWith(
                      color: Colors
                          .black),
                  keyboardType: TextInputType
                      .name,
                  textInputAction: TextInputAction
                      .next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets
                        .all(20),
                    hintText: 'Name of the Employee',
                    hintStyle: kBodyText,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors
                            .lightBlueAccent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius
                          .circular(
                          18),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors
                            .grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius
                          .circular(
                          18),
                    ),
                  ),
                  onChanged: (value){
                    setState((){
                      SearchedData=Name.where((element) => element.contains(add.text)).toList();
                      for(int i=0;i<SearchedData.length;i++){
                        SearchedCategory.add(type[Name.indexOf(SearchedData[i])]);
                      }
                    });
                  },
                ),
                // Names_of_Employees.length>=int.parse(widget.Members)?Text("You cannot add anymore Employees"):ElevatedButton(
                //     onPressed: () {
                //       if (add.text == "" || add.text == null) {
                //         Fluttertoast.showToast(msg: "Please Type Something in the textfield");
                //       } else {
                //         setState(() {
                //
                //           add.text = "";
                //         });
                //       }
                //
                //     },
                //     child: Text("Add")),
                Container(
                  height: 200,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: add.text==""?Name.length:SearchedData.length,
                        itemBuilder: (context, index){
                          return ListTile(title: Text(add.text==""?Name[index]:SearchedData[index]),
                          subtitle: Text(add.text==""?type[index]:SearchedCategory[index]),
                          trailing: Names_of_Employees.contains(add.text==""?Name[index]:SearchedData[index])? ElevatedButton(onPressed: (){ setState(() {
                            Names_of_Employees.remove(add.text==""?Name[index]:SearchedData[index]);
                           Category_of_Employees.remove(add.text==""?type[index]:SearchedCategory[index]);
                          });},child: Text("Remove"),):

                              ElevatedButton(onPressed: (){
                                print(Names_of_Employees.length);
                                setState(() {
                                  Names_of_Employees.add(add.text==""?Name[index]:SearchedData[index]);
                                 Category_of_Employees.add(add.text==""?type[index]:SearchedCategory[index]);
                                });
                              },child: Text("Add"),)
                          );
                        }),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    ):Container(
      height: 200,
        child: Center(child:Text("Something Goes Wrong"),));
  }
}
