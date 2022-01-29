import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:jobs_ui/widgets/text_button.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  String Attendance = "present";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance for Today"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Text(
                "1.)Vishal",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropDown<String>(
                // isExpanded: true,
                items: ["present", "absent"],
                hint: Text("present"),
                icon: Icon(
                  Icons.expand_more,
                  color: Colors.blue,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Text(
                "2.)Alex",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropDown<String>(
                // isExpanded: true,
                items: ["present", "absent"],
                hint: Text("present"),
                icon: Icon(
                  Icons.expand_more,
                  color: Colors.blue,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Text(
                "3.)Shady",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropDown<String>(
                // isExpanded: true,
                items: ["present", "absent"],
                hint: Text("present"),
                icon: Icon(
                  Icons.expand_more,
                  color: Colors.blue,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Text(
                "4.)Ansh",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropDown<String>(
                // isExpanded: true,
                items: ["present", "absent"],
                hint: Text("present"),
                icon: Icon(
                  Icons.expand_more,
                  color: Colors.blue,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Text(
                "5.)Sourav",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropDown<String>(
                // isExpanded: true,
                items: ["present", "absent"],
                hint: Text("present"),
                icon: Icon(
                  Icons.expand_more,
                  color: Colors.blue,
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
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
