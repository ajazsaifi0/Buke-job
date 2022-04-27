import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobs_ui/Helper%20Function/SF.dart';
// import 'package:jobs_ui/data/response.dart';
import 'package:jobs_ui/models/model.dart';
import 'package:jobs_ui/screens/JobPostForm.dart';
import 'package:jobs_ui/screens/Passbook.dart';
import 'package:jobs_ui/screens/RequestMadeApproval.dart';
import 'package:jobs_ui/screens/login.dart';
import 'package:jobs_ui/utlis/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'AboutUs.dart';
import 'AgentRequestScreen.dart';
import 'Profile.dart';
import 'Review.dart';

class Employer extends StatefulWidget {
 String Email_Id;
 String Name;
 String Address;
 String About;
 String Type;
 String Gender;
 String Mobile_No;
 String Pan_No;
 String Gst_No;
 String Company_Name;

 Employer(this.Email_Id,this.Name,this.Address,this.About,this.Type,this.Gender,this.Mobile_No,this.Gst_No,this.Pan_No,this.Company_Name);

  @override
  _EmployerState createState() => _EmployerState();
}

class _EmployerState extends State<Employer> {
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
  List<String> Title=[];
  List<String> Supervisor_Names=[];
  List<String> Mobile_Nos=[];
  List<String> Work_Start_Date=[];
  List<String> Work_End_Date=[];
  List<String> Cost_Per_Hour=[];
  List<String> Location=[];
  List<String> Preffered_Work=[];
  getData() async{
    String username = 'Bufe_Work';
    String password = 'Bufe_Work@123';
    String basicAuth =
        'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);

    var response=await http.post(Uri.parse("https://bufework.com/Api/object/Project.php?Email_Id="+widget.Email_Id),headers: <String, String>{'authorization': basicAuth},);
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
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Employer(widget.Email_Id,widget.Name,widget.Address,widget.About,widget.Type,widget.Gender,widget.Mobile_No,widget.Gst_No,widget.Pan_No,widget.Company_Name)));
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
           backgroundColor: Colors.grey[200],
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: BottomNavigationBar(
              unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
              selectedIconTheme: const IconThemeData(color: Colors.black),
              unselectedLabelStyle: const TextStyle(
                  color: colorPrimaryText, fontWeight: FontWeight.w500),
              selectedLabelStyle:
                  const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              fixedColor: Colors.indigo[100],
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
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/offers.png",
                      width: 20,
                      height: 20,
                    ),
                    label: 'Offers Received'),
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
                ? RequestMadeApproval(widget.Email_Id, 0,"Employer",widget.Name)
                : _currentIndex == 1
                    ? RequestMadeApproval(widget.Email_Id,1,"Employer",widget.Name)
                    :_currentIndex == 2?  AgentRequestScreen(widget.Email_Id,widget.Name)
            :ListView.builder(
                shrinkWrap: true,
                itemCount: Title.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 200,
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
                                Icon(Icons.calendar_today)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [Text(Supervisor_Names[index])],
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


                        ],
                      ),
                    ),
                  );
                }),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => JobPostForm("Employer",widget.Email_Id)));
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
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(
                        widget.Company_Name,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: colorPrimaryText),
                         textAlign: TextAlign.center,
                    ),
                     ),
                    const SizedBox(
                      height: 25,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(widget.Name,"N/A",widget.Address,widget.About,widget.Type,widget.Gender,widget.Mobile_No,widget.Company_Name,widget.Pan_No,widget.Gst_No)));
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Passbook(widget.Email_Id,"Employer")));
                      },
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
                      onTap: () {
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
                      onTap: ()  {
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
                      onTap: () async {

                         await HelperFunctions.saveUserLoggedInState(false);
                         await HelperFunctions.saveUserNameInSharedPrefrence("");
                         await HelperFunctions.savePassword("");

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));

                      },
                      leading: Icon(Icons.logout,color: Colors.blue,),
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
      color: Colors.blue[500],
    ),
  );
}
