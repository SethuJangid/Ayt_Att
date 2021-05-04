import 'dart:convert';

import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/MilestonesDetail.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/MilestonesPage.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/ProjectTaskDetails.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/models/ProjectTaskModel.dart';
import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProjectTaskScreen extends StatefulWidget {
  @override
  _ProjectTaskScreenState createState() => _ProjectTaskScreenState();
}

class _ProjectTaskScreenState extends State<ProjectTaskScreen> {
  String uniq_id;
  SharedPreferences sharedPreferences;
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
                "Project Task",
                style: TextStyle(color: AppConfig.appBarTextColor),
              )),
        ), //AppBar ,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              _widgetWeather(),
            ],
          ),
        )
    );
  }

  Widget _widgetWeather() {
    return FutureBuilder<ProjectTaskModel>(
        future: projectTask(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var imagePath = All_API().baseurl_img+snapshot.data.path+"/";
            sharedPreferences.setString("project_path", imagePath);
            return ListView.builder(
                itemCount: snapshot.data.data.length, //snapshot.data.data.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  var task = snapshot.data.data[index];
                  var dateStart = task.startTime.toIso8601String();
                  var date = dateStart.split(" ");
                  var startDate = date[0].toString().split("T");
                  var dateEnd = task.startTime.toIso8601String();
                  var date2 = dateEnd.split(" ");
                  var endDate = date2[0].toString().split("T");
                  print("---------> " + startDate.first + " " + endDate.first);
                  print("image---------> " + snapshot.data.path+"/"+task.documents);
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
                                        Image.network(All_API().baseurl_img+snapshot.data.path+"/"+task.documents,
                                          height: 20,
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
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>
                                            MilestonesPage(projectID: task.id,path: imagePath,)
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
                          Container(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        ProjectTaskDetailPage(
                                          startDate: startDate.first,
                                          endDate: endDate.first,
                                          name: task.name,
                                        )));
                              },
                              child: Text("Detail",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold), textAlign: TextAlign.end,),
                            ),
                          ),
                        )
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

  Future<ProjectTaskModel> projectTask() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var headers = {
      All_API().key: All_API().keyvalue,
    };
    var request = http.Request('GET', Uri.parse(All_API().baseurl+All_API().api_project_task));
    request.body = '{"employee_id":$uniq_id}';
    request.headers.addAll(headers);
    request.followRedirects = false;

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    Map json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print("Project ------>"+response.body);
      return ProjectTaskModel.fromJson(json);
    }
    else {
      print(response.reasonPhrase);
    }
  }
}
