// To parse this JSON data, do
//
//     final projectTaskModel = projectTaskModelFromJson(jsonString);

import 'dart:convert';

ProjectTaskModel projectTaskModelFromJson(String str) => ProjectTaskModel.fromJson(json.decode(str));

String projectTaskModelToJson(ProjectTaskModel data) => json.encode(data.toJson());

class ProjectTaskModel {
  ProjectTaskModel({
    this.status,
    this.msg,
    this.path,
    this.data,
  });

  bool status;
  String msg;
  String path;
  List<Datum> data;

  factory ProjectTaskModel.fromJson(Map<String, dynamic> json) => ProjectTaskModel(
    status: json["status"],
    msg: json["msg"],
    path: json["path"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "path": path,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.detail,
    this.requirement,
    this.startTime,
    this.endTime,
    this.documents,
    this.projectCost,
    this.clientName,
    this.clientEmail,
    this.clientPhone,
    this.clientAddress,
    this.projectManagerId,
    this.status,
    this.deleted,
    this.date,
  });

  String id;
  String name;
  String detail;
  String requirement;
  DateTime startTime;
  DateTime endTime;
  String documents;
  String projectCost;
  String clientName;
  String clientEmail;
  String clientPhone;
  String clientAddress;
  String projectManagerId;
  String status;
  String deleted;
  String date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    detail: json["detail"],
    requirement: json["requirement"],
    startTime: DateTime.parse(json["start_time"]),
    endTime: DateTime.parse(json["end_time"]),
    documents: json["documents"],
    projectCost: json["project_cost"],
    clientName: json["client_name"],
    clientEmail: json["client_email"],
    clientPhone: json["client_phone"],
    clientAddress: json["client_address"],
    projectManagerId: json["project_manager_id"],
    status: json["status"],
    deleted: json["deleted"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "detail": detail,
    "requirement": requirement,
    "start_time": "${startTime.year.toString().padLeft(4, '0')}-${startTime.month.toString().padLeft(2, '0')}-${startTime.day.toString().padLeft(2, '0')}",
    "end_time": "${endTime.year.toString().padLeft(4, '0')}-${endTime.month.toString().padLeft(2, '0')}-${endTime.day.toString().padLeft(2, '0')}",
    "documents": documents,
    "project_cost": projectCost,
    "client_name": clientName,
    "client_email": clientEmail,
    "client_phone": clientPhone,
    "client_address": clientAddress,
    "project_manager_id": projectManagerId,
    "status": status,
    "deleted": deleted,
    "date": date,
  };
}
