import 'dart:convert';

import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/MilestonesDetail.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/ProjectTaskDetails.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/Task%20Details.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/models/MilestoneListModel.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/models/ProjectTaskModel.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/models/TaskListModel.dart';
import 'package:AYT_Attendence/Screens/leavelists/track_leave.dart';
import 'package:AYT_Attendence/Screens/pages/trackattendance.dart';
import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'model/ReporterListModel.dart';

class ReporterDetail extends StatefulWidget {

  String name;
  String reporter_leave_id;
  String uniq_id;
  String reporter_id;
  ReporterDetail({
    this.name,this.reporter_leave_id,this.uniq_id,this.reporter_id
  });

  @override
  _ProjectTaskScreenState createState() => _ProjectTaskScreenState();
}

class _ProjectTaskScreenState extends State<ReporterDetail> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString("reporter_id", widget.reporter_id);
      sharedPreferences.setString("reporter_leave_id", widget.reporter_leave_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConfig.appColorMain,
          title: Padding(
              padding: const EdgeInsets.only(left: 6.0, top: 5.0),
              child: Text(
                "Reporter List",
                style: TextStyle(color: AppConfig.appBarTextColor),
              )),
        ), //AppBar ,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(child: Text(widget.name)),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              TrackAttendance(
                                  uniqId: widget.uniq_id
                              )
                          )
                      );
                    },
                    child: Card(
                      elevation: 8,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                        child: Text("Track Attendance"),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              MyTrackLeave(
                                unique_id: widget.uniq_id,
                              )
                          )
                      );
                    },
                    child: Card(
                      elevation: 8,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                        child: Text("Track Leave"),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              MyTrackLeave(
                                  unique_id: widget.id,
                              )
                          )
                      );*/
                    },
                    child: Card(
                      elevation: 8,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                        child: Text("Early CheckOut Request"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
