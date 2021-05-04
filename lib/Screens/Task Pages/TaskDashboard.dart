import 'package:AYT_Attendence/Screens/Task%20Pages/GeneralTaskScreen.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/ProjectTaskScreen.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/widgets/heading.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/widgets/project_card_tile.dart';
import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class TaskDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: true,
        backgroundColor: AppConfig.appColorMain,
        centerTitle: false,
        title: Padding(
            padding: const EdgeInsets.only(left: 6.0, top: 5.0),
            child: Text(
              "Task",
              style: TextStyle(color: AppConfig.appBarTextColor),
            )),
      ),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 22,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GeneralTaskScreen()));
                  },
                  child: Card(
                    color: Colors.orangeAccent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            AppConfig.generalTaskIcon,
                            height: 150,
                            width: 150,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "General Task",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProjectTaskScreen()));
                  },
                  child: Card(
                    color: Colors.orangeAccent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            AppConfig.projectTaskIcon,
                            height: 150,
                            width: 150,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Your Project",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                "Recent Task",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            /*Container(child: ProjectCardTile())*/
            Expanded(
              flex: 4,
              child: ProjectCardTile()
            )
          ]),
    );
  }
}
