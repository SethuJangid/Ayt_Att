import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MilestonesDetails extends StatefulWidget{
  String startDate;
  String endDate;
  String name;
  MilestonesDetails({
    this.startDate,
    this.endDate,
    this.name
  });
  @override
  _GeneralTaskDetailPageState createState() => _GeneralTaskDetailPageState();
}

class _GeneralTaskDetailPageState extends State<MilestonesDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConfig.appColorMain,
        title: Text(
          "Milestones Details",
          style: TextStyle(color: AppConfig.appBarTextColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Text(widget.name.toUpperCase()),
                ),
              ),
              Divider(
                height: 1,
                color: AppConfig.appColorMain,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Text("Assigned and Expire Date"),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.date_range,size: 20),
                  Text(widget.startDate+" To "+widget.endDate),
                ],
              ),
              Divider(
                height: 1,
                color: AppConfig.appColorMain,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Text("Requirement"),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  Divider(
                    height: 1,
                    color: AppConfig.appColorMain,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Text("Project Detail"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Text("hello this is task 1 for attendance"),
                  ),
                  SizedBox(
                    height: 250,
                  ),
                  Divider(
                    height: 1,
                    color: AppConfig.appColorMain,
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppConfig.buttonColor,
        foregroundColor: AppConfig.appColorMain,
        child: Icon(Icons.add,size: 20,),
      ),
    );
  }
}