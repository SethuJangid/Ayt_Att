import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class ProjectCardTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: null,
      builder: (context, snapshot) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, snapshot) {
            /*return Card(
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)
                  ),
                ),
                margin: const EdgeInsets.only(
                    top: 5, left: 2, bottom: 5, right: 2),
                child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 5.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(
                                  width: 5.0,
                                  color: Colors.green))),
                      child: Image.asset(
                        AppConfig.iconApproved,
                        height: 70,
                        width: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Task Name",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.orange,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 5.0)),
                            Text("10 Task",
                              style: TextStyle(fontSize: 15, color: Colors.black54),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                  Icons.date_range_rounded,
                                  color: AppConfig.fontColor),
                            ),
                            Text(
                              "12-03-2021 TO 24-03-2021",
                              style: TextStyle(
                                  fontSize: 14,
                                  color:
                                  Colors.black54,
                                  fontWeight:
                                  FontWeight
                                      .w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: Colors.black54,
                        size: 30.0)),
              ),
            );*/
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5, vertical: 2),
              child: Card(
                elevation: 8,
                color: AppConfig.fixedCardColor2,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: AppConfig.colorBlack)
                          )
                      ),
                      child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          title: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "Recent Task Name",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 5.0)),
                                  Text("Recent Task Description",
                                    style: TextStyle(fontSize: 10,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                        Icons.date_range_rounded,
                                        color: AppConfig.fontColor),
                                  ),
                                  Text(
                                    "12/03/2021" + " To " +
                                        "21/03/2021",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                        Colors.black,
                                        fontWeight:
                                        FontWeight
                                            .w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: GestureDetector(
                            /*onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) =>
                                                MilestonesDetails(
                                                  startDate: startDate.first,
                                                  endDate: endDate.first,
                                                  name: task.name,
                                                )
                                            )
                                        );
                                      },*/
                            child: Icon(
                              Icons.visibility_outlined,
                              color: Colors.black54,
                              size: 25.0,
                            ),
                          )
                      ),
                    ),
                    Container(
                      height: 30,
                      //alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        /*child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>
                                              TaskList(
                                                startDate: startDate.first,
                                                endDate: endDate.first,
                                                name: task.name,
                                              )));
                                    },
                                    child: Text("Detail", textAlign: TextAlign.end,),
                                  ),*/
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }
}
