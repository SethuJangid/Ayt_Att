import 'dart:convert';

import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/MilestonesDetail.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/ProjectTaskDetails.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/Task%20Details.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/models/MilestoneListModel.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/models/ProjectTaskModel.dart';
import 'package:AYT_Attendence/Screens/Task%20Pages/models/TaskListModel.dart';
import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'ReporterDetail.dart';
import 'model/ReporterListModel.dart';

class ReporterList extends StatefulWidget {

  @override
  _ProjectTaskScreenState createState() => _ProjectTaskScreenState();
}

class _ProjectTaskScreenState extends State<ReporterList> {

  String uniq_id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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
                "Reporter List",
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
    return FutureBuilder<ReporterListModel>(
        future: taskList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.data.length, //snapshot.data.data.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  var task = snapshot.data.data[index];
                  //var path = All_API().baseurl_img+snapshot.data.path;
                  var path = All_API().baseurl_img+All_API().profile_img_path;
                  print("name---------> " + task.name);
                  print("image---------> " + path+task.image);
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 2),
                    child: Card(
                      elevation: 8,
                      color: AppConfig.fixedCardColor2,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
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
                                leading: task.image==null?ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    AppConfig.userIconDefault,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ):ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    path+task.image,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ),
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
                                trailing: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>
                                          ReporterDetail(
                                            name: task.name,
                                            reporter_id: task.reporterId,
                                            reporter_leave_id: task.id,
                                            uniq_id: task.uniqueId,
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
          return Center(
            child: Card(
              color: AppConfig.appColorMain,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  All_API().two_error_occurred,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.orange,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }
    );
  }

  Future<ReporterListModel> taskList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var headers = {
      All_API().key: All_API().keyvalue,
    };
    var request = http.Request('GET', Uri.parse(All_API().baseurl+All_API().api_report_list+uniq_id));
    //print("Reporter URL----->"+All_API().baseurl+All_API().api_report_list+"NODF6F9G3R2P5A");
    print("Reporter URL----->"+All_API().baseurl+All_API().api_report_list+uniq_id);

    request.headers.addAll(headers);
    request.followRedirects = false;

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    Map json = jsonDecode(response.body);
    print("Milestone List----->" +response.body);

    if (response.statusCode == 200) {
      print("Milestone List----->" +response.body);
      return ReporterListModel.fromJson(json);
    }
    else {
      print(response.reasonPhrase);
    }
  }
}
