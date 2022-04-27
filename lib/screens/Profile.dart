import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobs_ui/screens/Profile%20Update%20Form.dart';

class Profile extends StatefulWidget {
  String Name;

  String Preffered_Worker;
  String Address;
  String About;
  String Type;
  String Gender;
  String Mobile_No;
  String? Company_Name;
  String? Pan_No;
  String? Gst_No;
  String? Email_Id;
  Profile(this.Name,this.Preffered_Worker,this.Address,this.About,this.Type,this.Gender,this.Mobile_No,this.Email_Id,[this.Company_Name,this.Pan_No,this.Gst_No]) {
    // TODO: implement

  }


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                child: Container(
                  alignment: Alignment(0.0,2.5),
                  child:
                  Image.asset(
                    widget.Preffered_Worker=="Mason"? 'assets/images/Mason.png':
                    widget.Preffered_Worker=="Labour"?'assets/images/Labour.png':
                    widget.Preffered_Worker=="Carpenter"?  'assets/images/Carpenter.png':
                    widget.Preffered_Worker=="Core-Cutting"?'assets/images/Core-Cutting.png':
                    widget.Preffered_Worker=="CraneOperator"?'assets/images/CraneOperator.png':
                    widget.Preffered_Worker=="Electrician"?'assets/images/Electrician.png':
                    widget.Preffered_Worker=="Excavation"?'assets/images/Excavation.png':
                    widget.Preffered_Worker=="Flooring"?'assets/images/Flooring.png':
                    widget.Preffered_Worker=="Formwork"?'assets/images/Formwork.png':
                    widget.Preffered_Worker=="Paint"?'assets/images/Paint.png':
                    widget.Preffered_Worker=="Plastering"?'assets/images/Plastering.png':
                    widget.Preffered_Worker=="Plumber"?'assets/images/Plumber.png':
                    widget.Preffered_Worker=="RCC"?'assets/images/RCC.png':
                    widget.Preffered_Worker=="Scaffolding"?'assets/images/Scaffolding.png':
                    widget.Preffered_Worker=="Security"?'assets/images/Security.png':
                    widget.Preffered_Worker=="Scaffolding"?'assets/images/Scaffolding.png':
                    widget.Preffered_Worker.contains("Steel")?'assets/images/Steel.png':
                    widget.Preffered_Worker=="StoneBreaker"?'assets/images/StoneBreaker.png':
                    widget.Preffered_Worker=="StonePolishing"?'assets/images/StonePolishing.png':
                    widget.Preffered_Worker=="Welding"?'assets/images/Welding.png':
                    widget.Preffered_Worker=="woodPolishing"?'assets/images/woodPolishing.png'
                        :'assets/images/woodPolishing.png',
                  ),
                  // CircleAvatar(
                  //   child: Icon(Icons.person,size: 60,),
                  //   radius: 60.0,
                  // ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                widget.Name
                ,style: TextStyle(
                  fontSize: 25.0,
                  color:Colors.indigo,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w400
              ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              widget.Company_Name!=null?Text("("+widget.Company_Name!+")"):Text("")
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.Address
                ,style: TextStyle(
                  fontSize: 18.0,
                  color:Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
              ),
              SizedBox(
                height: 10,
              ),
              widget.Gst_No!=null?
              Text(
               "Gst No:"+ widget.Gst_No!
                ,style: TextStyle(
                  fontSize: 18.0,
                  color:Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
              ):Text(""),
              widget.Pan_No!=null?
              Text(
                "Pan No:"+ widget.Pan_No!
                ,style: TextStyle(
                  fontSize: 18.0,
                  color:Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
              ):Text(""),
              Text(
                widget.About
                ,style: TextStyle(
                  fontSize: 15.0,
                  color:Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
              ),


              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  widget.Type+"||"+widget.Gender
                  ,style: TextStyle(
                    fontSize: 18.0,
                    color:Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300
                ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text("Mobile Number",
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w600
                              ),),
                            SizedBox(
                              height: 7,
                            ),
                            Text(widget.Mobile_No,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w300
                              ),)
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo, // background
                    onPrimary: Colors.indigo, // foreground
                  ),
                  onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileUpdateForm(widget.Name, widget.Address,widget.Email_Id)));
              }, child: Text("Update Details",style: TextStyle(color: Colors.white),))

            ],
          ),
        )
    );
  }
}
