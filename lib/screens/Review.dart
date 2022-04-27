import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobs_ui/utlis/constants.dart';
class Review extends StatefulWidget {
String? Name;
Review(this.Name);
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  String Feedback ="";
  List<String> Reviews=[];
  List<String> Names=[];
  UploadFeedback()async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var requestBody={
      "Name":widget.Name,
      "Text":Feedback
    };
    try {
      var response = await http.post(
          Uri.parse("https://Bufework.com/Api/object/feedback.php"),
          headers: <String, String>{'authorization': basicAuth},
          body: json.encode(requestBody));
      dynamic res = json.decode(response.body.toString());
      if (response.statusCode == 200) {
        print(res);
        Fluttertoast.showToast(msg: res["message"]);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Review(widget.Name)));
      }
    }catch(e){
      Fluttertoast.showToast(msg: "Something goes Wrong");
    }
  }
  getFeedback()async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);

    try {
      var response = await http.post(
          Uri.parse("https://Bufework.com/Api/object/feedback_data.php"),
          headers: <String, String>{'authorization': basicAuth},
          );
      dynamic res = json.decode(response.body.toString());
      if (response.statusCode == 200) {
        print(res);

        for(int i=0;i<res["body"].length;i++){
          if(res["body"][i]["Type"]==widget.Name) {
            setState(() {
              Reviews.add(res["body"][i]["Title"]);
              Names.add(res["body"][i]["Type"]);
            });
          }
        }
      }
    }catch(e){
      Fluttertoast.showToast(msg: "Something goes Wrong");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    getFeedback();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Feedback Form"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextField(
              maxLines: 8,
              //controller: Duration,
              style: kBodyText.copyWith(color: Colors.black),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(20),
                hintText: 'Enter your Feedback here',
                hintStyle: kBodyText,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.indigo,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onChanged: (value){
                Feedback=value;
              },
            ),
          ),
          ElevatedButton(
              onPressed: (){
            UploadFeedback();
          }, child: Text("Submit")),
          Reviews.length==0?Text("No Previous Feedbacks"):ListView.builder(
              shrinkWrap: true,
              itemCount: Reviews.length,
              itemBuilder: (BuildContext context,int index){
                return Card(
                  elevation: 5,
                  child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(Reviews[index]),
                        Text("-By "+Names[index],style: TextStyle(
                          color: Colors.grey
                        ),)
                      ],
                    ),
                  ),
                  ),
                );
              }
          )
        ],
      ),
    );
  }
}
