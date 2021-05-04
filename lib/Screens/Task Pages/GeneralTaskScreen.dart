import 'dart:convert';

import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/GeneralTaskDetails.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/MilestonesDetail.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/MilestonesPage.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/Task%20Details.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/models/GeneralTaskModel.dart';
import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GeneralTaskScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GeneralTaskState();
  }
}

class GeneralTaskState extends State<GeneralTaskScreen> {

  SharedPreferences sharedPreferences;
  String uniq_id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  getData()async{
     sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      uniq_id = sharedPreferences.getString("unique_id");
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
                "General Task",
                style: TextStyle(color: AppConfig.appBarTextColor),
              )),
        ), //AppBar ,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                margin:EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              height: 20,
                              width: 20,
                              color: AppConfig.lowColor,
                            ),
                          ),
                          Text("Low"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              height: 20,
                              width: 20,
                              color: AppConfig.mediumColor,
                            ),
                          ),
                          Text("Medium"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              height: 20,
                              width: 20,
                              color: AppConfig.highColor,
                            ),
                          ),
                          Text("High"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              height: 20,
                              width: 20,
                              color: AppConfig.urgentColor,
                            ),
                          ),
                          Text("Urgent")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _widgetWeather(),
            ],
          ),
        )
    );
  }

  Widget _widgetWeather(){
    return FutureBuilder<GeneralTaskModel>(
      future: generalTask(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var imgPath = All_API().baseurl_img+snapshot.data.path;
          sharedPreferences.setString("task_path", imgPath);
          print("path ---------->"+imgPath);
          return ListView.builder(
              itemCount: snapshot.data.data.length, //snapshot.data.data.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                var task = snapshot.data.data[index];
                var priorityId = task.priorityId;
                var dateStart = task.startTime.toIso8601String();
                var date = dateStart.split(" ");
                var startDate = date[0].toString().split("T");
                var dateEnd = task.startTime.toIso8601String();
                var date2 = dateEnd.split(" ");
                var endDate = date2[0].toString().split("T");
                print("---------> " + startDate.first + " " + endDate.first);
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5, vertical: 2),
                  child: Card(
                    elevation: 8,
                    color: AppConfig.colorWhite,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 8,
                                      color: priorityId == "1" ? AppConfig
                                          .lowColor :
                                      priorityId == "2"
                                          ? AppConfig.mediumColor
                                          :
                                      priorityId == "3" ? AppConfig.highColor :
                                      priorityId == "4"
                                          ? AppConfig.urgentColor
                                          : AppConfig.colorWhite)
                              )
                          ),
                          child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              title: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  task.name,
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
                                      Text(task.description,
                                        style: TextStyle(fontSize: 15,
                                            color: Colors.black54),
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
                                        startDate.first + " To " +
                                            endDate.first,
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
                              trailing: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          GeneralTaskDetailPage(
                                            startDate: startDate.first,
                                            endDate: endDate.first,
                                            name: task.name,
                                            taskColor: priorityId == "1" ? AppConfig
                                                .lowColor :
                                            priorityId == "2"
                                                ? AppConfig.mediumColor
                                                :
                                            priorityId == "3" ? AppConfig.highColor :
                                            priorityId == "4"
                                                ? AppConfig.urgentColor
                                                : AppConfig.colorWhite,
                                            priority: priorityId == "1" ? "Low" :
                                            priorityId == "2"
                                                ? "Medium"
                                                :
                                            priorityId == "3" ? "High" :
                                            priorityId == "4"
                                                ? "Urgent"
                                                : "",
                                            description: task.description,
                                            document: task.documents,
                                            path: imgPath+"/",
                                            task_id: task.id,
                                          )
                                      )
                                  );
                                },
                                child: Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.black54,
                                  size: 25.0,
                                ),
                              )
                          ),
                        ),
                        /*Container(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        GeneralTaskDetailPage(
                                          startDate: startDate.first,
                                          endDate: endDate.first,
                                          name: task.name,
                                        )));
                              },
                              child: Text("Detail", textAlign: TextAlign.end,),
                            ),
                          ),
                        )*/
                      ],
                    ),
                  ),
                );
              }
          );
        }
        return Center(child: CircularProgressIndicator());
      }
    );

  }

  Future<GeneralTaskModel> generalTask() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var headers = {
      All_API().key: All_API().keyvalue,
    };
    var request = http.Request('GET', Uri.parse(All_API().baseurl+All_API().api_general_task));
    request.body = '''{"employee_id":"$uniq_id"}''';

    request.headers.addAll(headers);
    request.followRedirects = false;

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    Map json = jsonDecode(response.body);

    return GeneralTaskModel.fromJson(json);
  }
}
