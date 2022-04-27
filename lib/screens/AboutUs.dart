import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Who are We",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: Text(
                      "Bufe Work is Asia's largest online Job services platform.  Launched in 2014, Bufe Work today operates in India, Australia, Singapore, the UAE and The Kingdom of Saudi Arabia. The platform helps customers book reliable & high quality services -  beauty treatments, massages, haircuts, home cleaning, handymen, appliance repair, painting, pest control and more â€“ delivered by trained professionals conveniently at home.   Bufe Work vision is to empower millions of professionals worldwide to deliver services at home like never experienced before. The Company raised Series F funding of USD 255 million in April 2021. The Series F round was led by new investors - Prosus Ventures, Dragoneer and Wellington Management with participation from existing investors - Vy Capital, Tiger Global and Steadview. The latest round includes a primary capital infusion of USD 188 million and a secondary sale of approximately USD 67 million by select angels and early investors")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "How We Do It",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: Text(
                      "Bufe work is Asia's largest online job services platform.  Launched in 2014, Bufe work today operates in India, Australia, Singapore, the UAE and The Kingdom of Saudi Arabia. The platform helps customers book reliable & high quality services -  beauty treatments, massages, haircuts, home cleaning, handymen, appliance repair, painting, pest control and more â€“ delivered by trained professionals conveniently at home.   Bufe Work's vision is to empower millions of professionals worldwide to deliver services at home like never experienced before. The Company raised Series F funding of USD 255 million in April 2021. The Series F round was led by new investors - Prosus Ventures, Dragoneer and Wellington Management with participation from existing investors - Vy Capital, Tiger Global and Steadview. The latest round includes a primary capital infusion of USD 188 million and a secondary sale of approximately USD 67 million by select angels and early investors")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Our Story so Far",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: Text(
                      "Bufe Work is Asia's largest online home services platform.  Launched in 2014, BufeWork today operates in India, Australia, Singapore, the UAE and The Kingdom of Saudi Arabia. The platform helps customers book reliable & high quality services -  beauty treatments, massages, haircuts, home cleaning, handymen, appliance repair, painting, pest control and more â€“ delivered by trained professionals conveniently at home.   Bufe Work vision is to empower millions of professionals worldwide to deliver services at home like never experienced before. The Company raised Series F funding of USD 255 million in April 2021. The Series F round was led by new investors - Prosus Ventures, Dragoneer and Wellington Management with participation from existing investors - Vy Capital, Tiger Global and Steadview. The latest round includes a primary capital infusion of USD 188 million and a secondary sale of approximately USD 67 million by select angels and early investors")),
            )
          ],
        ),
      ),
    );
  }
}
