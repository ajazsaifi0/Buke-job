import 'package:flutter/material.dart';
import 'package:jobs_ui/screens/employee.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<String> Images = [
    "assets/images/Labour.png",
    "assets/images/Mason.png",
    "assets/images/Plumber.png",
    "assets/images/SteelBender.png"
  ];
  List<String> name = ["Labour", "Mason", "Plumber", "SteelBender"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Your Category"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Please Select Your Category",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              ),
            ),
            GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 8.0,
                children: List.generate(4, (index) {
                  return GestureDetector(
                    child: Card(
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          Image.asset(
                            Images[index],
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                          Text(name[index]),
                          SizedBox(),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Employee()));
                    },
                  );
                })),
          ],
        ));
  }
}
