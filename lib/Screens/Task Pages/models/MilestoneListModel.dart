// To parse this JSON data, do
//
//     final milestoneListModel = milestoneListModelFromJson(jsonString);

import 'dart:convert';

MilestoneListModel milestoneListModelFromJson(String str) => MilestoneListModel.fromJson(json.decode(str));

String milestoneListModelToJson(MilestoneListModel data) => json.encode(data.toJson());

class MilestoneListModel {
  MilestoneListModel({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  List<Datum> data;

  factory MilestoneListModel.fromJson(Map<String, dynamic> json) => MilestoneListModel(
    status: json["status"],
    msg: json["msg"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.projectId,
    this.description,
    this.startTime,
    this.endTime,
    this.status,
    this.deleted,
    this.date,
  });

  String id;
  String name;
  String projectId;
  String description;
  DateTime startTime;
  DateTime endTime;
  String status;
  String deleted;
  String date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    projectId: json["project_id"],
    description: json["description"],
    startTime: DateTime.parse(json["start_time"]),
    endTime: DateTime.parse(json["end_time"]),
    status: json["status"],
    deleted: json["deleted"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "project_id": projectId,
    "description": description,
    "start_time": "${startTime.year.toString().padLeft(4, '0')}-${startTime.month.toString().padLeft(2, '0')}-${startTime.day.toString().padLeft(2, '0')}",
    "end_time": "${endTime.year.toString().padLeft(4, '0')}-${endTime.month.toString().padLeft(2, '0')}-${endTime.day.toString().padLeft(2, '0')}",
    "status": status,
    "deleted": deleted,
    "date": date,
  };
}
