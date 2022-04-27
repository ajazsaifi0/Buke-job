import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobs_ui/Helper%20Function/SF.dart';
// import 'package:jobs_ui/data/response.dart';
import 'package:jobs_ui/models/model.dart';
import 'package:jobs_ui/screens/AgentRequestScreen.dart';
import 'package:jobs_ui/screens/EmployeeDetailsforagent.dart';
import 'package:jobs_ui/screens/RequestMadeApproval.dart';
import 'package:jobs_ui/screens/ShowModal.dart';
import 'package:jobs_ui/screens/registration.dart';
import 'package:jobs_ui/utlis/colors.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_ui/utlis/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'AboutUs.dart';
import 'AttendanceSheet.dart';
import 'JobPostForm.dart';
import 'Passbook.dart';
import 'Profile.dart';
import 'Review.dart';
import 'login.dart';

class Agent extends StatefulWidget {
  String Email_Id;
  String Name;
  String Address;
  String About;
  String Type;
  String Gender;
  String Mobile_No;
  Agent(this.Email_Id,this.Name,this.Address,this.About,this.Type,this.Gender,this.Mobile_No);
  @override
  _AgentState createState() => _AgentState();
}

class _AgentState extends State<Agent> {
  final _advancedDrawerController = AdvancedDrawerController();
  int counter = 0;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  int _currentIndex = 0;
  final List<Widget> _widgetList = [
    // My Work

    // const Text('Page One'),

    const Text('Page Two'),
    const Text('Page Three'),
    const Text('Page Four'),
  ];

  final List<String> _textList = [
    "My Work",
    "Request Made",
    "Offers Received",
    "My Jobs",
  ];
  List<String> Title=[];
  List<String> Supervisor_Names=[];
  List<String> Mobile_Nos=[];
  List<String> Work_Start_Date=[];
  List<String> Work_End_Date=[];
  List<String> Cost_Per_Hour=[];
  List<String> Location=[];
  List<String> Preffered_Work=[];
  List<String> MembersRequired=[];
  List<dynamic> C_Email_Id=[];
  List<String> Description=[];
  List<String> Holiday=[];
 getData() async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);

    var response=await http.post(Uri.parse("https://Bufework.com/Api/object/Jobdetails.php"),headers: <String, String>{'authorization': basicAuth},);
   dynamic res=json.decode(response.body.toString());
    //final res= await json.decode(json.encode(response.body.toString()));
        if(response.statusCode==200){
      print(res);
      print(res["body"].length);
      //print();
      if(res["body"][0]["status"]==true) {
        for(int i=0;i<res["body"].length;i++){
          setState(() {
            Title.add(res["body"][i]["Title"]);
            Supervisor_Names.add(res["body"][i]["Supervisor_Name"]);
            Mobile_Nos.add(res["body"][i]["Mobile_No"]);
            Work_Start_Date.add(res["body"][i]["Work_Start_Date"]);
            Work_End_Date.add(res["body"][i]["Work_End_Date"]);
            Cost_Per_Hour.add(res["body"][i]["Cost_Per_Hour"]);
            Location.add(res["body"][i]["Location"]);
            Preffered_Work.add(res["body"][i]["Prefferd_Work"]);
            MembersRequired.add(res["body"][i]["Member"]);
            C_Email_Id.add(res["body"][i]["Email_Id"]);
            Description.add(res["body"][i]["Description"]);
            Holiday.add(res["body"][i]["Holiday"]);
          });
        }
        print(Title);
        print(Supervisor_Names);
        print(Mobile_Nos);
        print(Work_Start_Date);
        print(Work_End_Date);
        print(Cost_Per_Hour);
        print(Location);

      }else{
        Fluttertoast.showToast(
            msg: res["message"]);
      }
    }else{
      Fluttertoast.showToast(
          msg: "you have no work to show");
    }
  }

  _sendingMails(String input) async {
    String url;
    if (input.contains('mail')) {
      url = 'mailto:contact@BufeWork.in';
      await launch(url);
    } else {
      url = 'tel:1234567890';
      await launch(url);
    }
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
  Future<void> _onRefresh()async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Agent(widget.Email_Id,widget.Name,widget.Address,widget.About,widget.Type,widget.Gender,widget.Mobile_No)));
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()  async => false,
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: AdvancedDrawer(
          backdropColor: const Color(0xffE7DDDC),
          controller: _advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor:Colors.indigo,
              title: Text(
                _textList[_currentIndex],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ),
              ),
              // elevation: 0,
              //backgroundColor: colorBackground,
              leading: IconButton(
                onPressed: _handleMenuButtonPressed,
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: _advancedDrawerController,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Image.asset(
                        value.visible
                            ? "assets/images/close.png"
                            : "assets/images/hamburger.png",
                        width: 18,
                        height: 18,
                        key: ValueKey<bool>(value.visible),
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
            backgroundColor: colorBackground,
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: BottomNavigationBar(
              unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
              selectedIconTheme: const IconThemeData(color: Colors.black),
              unselectedLabelStyle: const TextStyle(
                  color: colorPrimaryText, fontWeight: FontWeight.w500),
              selectedLabelStyle:
                  const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              fixedColor: Colors.indigoAccent[100],
              type: BottomNavigationBarType.fixed,
              onTap: onTapped,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/work.png",
                      width: 20,
                      height: 20,
                    ),
                    label: 'My Work'),
                BottomNavigationBarItem(
                    icon: Image.asset("assets/images/request.png",
                        width: 20, height: 20),
                    label: 'Request Made'),
                // BottomNavigationBarItem(
                //     icon: Image.asset(
                //       "assets/images/offers.png",
                //       width: 20,
                //       height: 20,
                //     ),
                //     label: 'Offers Received'),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/search.png",
                      width: 20,
                      height: 20,
                    ),
                    label: 'Jobs Uploaded'),
              ],
            ),
            body: _currentIndex == 0
                ? RequestMadeApproval(widget.Email_Id, 0,"Agent",widget.Name)
                : _currentIndex == 1
                    ? RequestMadeApproval(widget.Email_Id, 1,"Agent",widget.Name)
                    //:_currentIndex == 2?  AgentRequestScreen(widget.Email_Id)
            //     ListView.builder(
                // shrinkWrap: true,
                // itemCount: Title.length,
                // itemBuilder: (BuildContext context, int index) {
                //   return Container(
                //     height: 240,
                //     child: Card(
                //       elevation: 3,
                //       child: Column(
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Row(
                //               mainAxisAlignment:
                //               MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Text(
                //                   Title[index],
                //                   style: TextStyle(
                //                       fontSize: 18,
                //                       fontWeight: FontWeight.bold),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Row(
                //               mainAxisAlignment:
                //               MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Text("Name of Supervisor: "+Supervisor_Names[index]),
                //                 Text("Uploaded By: ")
                //               ],
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Row(
                //               mainAxisAlignment:
                //               MainAxisAlignment.spaceBetween,
                //               children: [
                //                 FittedBox(child: Text("Contact No.: "+Mobile_Nos[index])),
                //                 FittedBox(child: Text("Location of Work: "+Location[index])),
                //
                //               ],
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Row(
                //               mainAxisAlignment:
                //               MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Text("Cost Per Day:₹"+Cost_Per_Hour[index]),
                //                 Text("Holidays:")
                //               ],
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Row(
                //               mainAxisAlignment:
                //               MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Text("Start date:"+Work_Start_Date[index].substring(0,10)),
                //                 Text("End date:"+Work_End_Date[index].substring(0,10))
                //               ],
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Row(
                //               mainAxisAlignment:
                //               MainAxisAlignment.spaceEvenly,
                //               children: [
                //                 Container(
                //                   color: Colors.red,
                //                   child: TextButton(
                //                       onPressed: () {
                //                         //  Apply(index);
                //                       },
                //                       child: Text(
                //                         "Reject",
                //                         style: TextStyle(
                //                             color: Colors.white),
                //                       )),
                //                 ),
                //                 Container(
                //                   color: Colors.blue,
                //                   child: TextButton(
                //                       onPressed: () {
                //                       //  Apply(index);
                //                       },
                //                       child: Text(
                //                         "Accept",
                //                         style: TextStyle(
                //                             color: Colors.white),
                //                       )),
                //                 )
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   );
                // })
            :ListView.builder(
                shrinkWrap: true,
                itemCount: Title.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 250,
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
                                GestureDetector(child: Icon(Icons.message,color: Colors.indigo,),onTap:() async{
                                 dynamic uri = 'sms:'+Mobile_Nos[index]+'?body=Welcome to bufe';
                                 if (await canLaunch(uri)) {
                                   await launch(uri);
                                 } else {
                                   // iOS
                                   dynamic uri = 'sms:'+Mobile_Nos[index]+'?body=Welcome to bufe';
                                   if (await canLaunch(uri)) {
                                     await launch(uri);
                                   } else {
                                     throw 'Could not launch $uri';
                                   }
                                 }
                                },)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Agent Name:"+Supervisor_Names[index]),Text("Employees Required:"+MembersRequired[index])],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Phone No.:+91"+Mobile_Nos[index]),
                                Text("Preffered Worker:"+Preffered_Work[index]),

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Cost Per Day:₹"+Cost_Per_Hour[index]),
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
                                Text("End Date:"+Work_End_Date[index].substring(0,10)),

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
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                            border:Border.all(
                              color: Colors.indigo,
                              // red as border color

                            ),
                              borderRadius: BorderRadius.circular(10),
                          ),

                                  child: TextButton(
                                      onPressed: () {
                                       // Apply(index);s
                                        showModalBottomSheet(
                                          context: context,
                                          // color is applied to main screen when modal bottom screen is displayed
                                          //barrierColor: Colors.greenAccent,
                                          //background color for modal bottom screen
                                          backgroundColor: Colors.white,
                                          //elevates modal bottom screen
                                          elevation: 10,
                                          isScrollControlled: true,
                                          // gives rounded corner to modal bottom screen
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          builder: (_)=>ShowModal(Members:MembersRequired[index],
                                            U_Email_Id: widget.Email_Id,
                                            Email_Id: C_Email_Id[index],
                                            Name: widget.Name,
                                            Title: Title[index],
                                            Supervisor_Name: Supervisor_Names[index],
                                            Mobile_No: Mobile_Nos[index],
                                            Location: Location[index],
                                            Description: Description[index],
                                            Cost_Per_Hour: Cost_Per_Hour[index],
                                            Holiday: Holiday[index],
                                            Work_Start_Date: Work_Start_Date[index],
                                            Work_End_Date: Work_End_Date[index],
                                            Prefferd_Work: Preffered_Work[index],
                                          )
                                        );
                                      },
                                      child: Text(
                                        "Apply",
                                        style: TextStyle(
                                            color: Colors.white,fontSize: 15),
                                      )),
                                )
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                  );
                }),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Register(from: "Agent",)));
              },
              child: Icon(Icons.add),
            ),

            //_widgetList[_currentIndex]
          ),
          drawer: SafeArea(
            child: Container(
              child: ListTileTheme(
                textColor: Colors.white,
                iconColor: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 128.0,
                      height: 128.0,
                      margin: const EdgeInsets.only(
                        top: 34.0,
                        bottom: 24.0,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xff8693AB),
                            Color(0xffBDD4E7),
                          ],
                        ),
                        // color: Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/company.png',
                      ),
                    ),
                    Text(
                      widget.Name,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: colorPrimaryText),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(widget.Name,"N/A",widget.Address,widget.About,widget.Type,widget.Gender,widget.Mobile_No,widget.Email_Id)));

                      },
                      leading: Image.asset(
                        "assets/images/profile.png",
                        width: 30,
                        height: 30,
                      ),
                      title: const Text('Profile',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: colorSecondaryText)),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EmployeeDataForAgent()));
                      },
                      leading: Image.asset(
                        "assets/images/profile.png",
                        width: 30,
                        height: 30,
                      ),
                      title: const Text('Employees',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: colorSecondaryText)),
                    ),

                    ListTile(
                      onTap: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Passbook(widget.Email_Id,"Agent")));},
                      leading: Image.asset(
                        "assets/images/passbook.png",
                        width: 30,
                        height: 30,
                      ),
                      title: const Text(
                        'Passbook',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: colorSecondaryText),
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        await launch(
                            "https://play.google.com/store/apps/details?id=com.kiloo.subwaysurf&hl=en_US&gl=US");

                      },
                      leading: Image.asset(
                        "assets/images/invite.png",
                        width: 30,
                        height: 30,
                      ),
                      title: const Text(
                        'Invite',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: colorSecondaryText),
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        _sendingMails('mail');
                      },
                      leading: Image.asset(
                        "assets/images/help.png",
                        width: 30,
                        height: 30,
                      ),
                      title: const Text(
                        'Help',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: colorSecondaryText),
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Review(widget.Name)));
                        // await launch(
                        //     "https://play.google.com/store/apps/details?id=com.kiloo.subwaysurf&hl=en_US&gl=US");

                      },
                      leading: Image.asset(
                        "assets/images/feedback.png",
                        width: 30,
                        height: 30,
                      ),
                      title: const Text(
                        'Feedback',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: colorSecondaryText),
                      ),
                    ),
                    // ListTile(
                    //   onTap: () {},
                    //   leading: Image.asset(
                    //     "assets/images/settings.png",
                    //     width: 30,
                    //     height: 30,
                    //   ),
                    //   title: const Text(
                    //     'Settings',
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w500, color: colorSecondaryText),
                    //   ),
                    // ),
                    ListTile(
                      onTap: () {
                        SetLogoutState();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs()));

                      },
                      leading: Image.asset(
                        "assets/images/about.png",
                        width: 30,
                        height: 30,
                      ),
                      title: const Text(
                        'About Us',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: colorSecondaryText),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        SetLogoutState();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));

                      },
                      leading: Icon(Icons.logout,color: Colors.indigo,),
                      title: const Text(
                        'Log Out',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: colorSecondaryText),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
SetLogoutState()async{
  await HelperFunctions.saveUserLoggedInState(false);
  await HelperFunctions.saveUserNameInSharedPrefrence("");
  await HelperFunctions.savePassword("");
}
  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}



ListView _employees(data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
            child: _tile(data[index].employeeName, data[index].employeeSalary,
                Icons.work));
      });
}

ListTile _tile(String title, String subtitle, IconData icon) {
  return ListTile(
    title: Text(title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: Colors.indigo[500],
    ),
  );
}
