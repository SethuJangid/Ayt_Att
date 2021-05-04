
import 'dart:convert';

TaskListModel taskListModelFromJson(String str) => TaskListModel.fromJson(json.decode(str));

String taskListModelToJson(TaskListModel data) => json.encode(data.toJson());

class TaskListModel {
  TaskListModel({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  List<Datum> data;

  factory TaskListModel.fromJson(Map<String, dynamic> json) => TaskListModel(
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
    this.startTime,
    this.endTime,
    this.milestoneId,
    this.description,
    this.documents,
    this.empComplete,
    this.completeDate,
    this.lateSubmitted,
    this.status,
    this.deleted,
    this.date,
  });

  String id;
  String name;
  DateTime startTime;
  DateTime endTime;
  String milestoneId;
  String description;
  String documents;
  String empComplete;
  String completeDate;
  String lateSubmitted;
  String status;
  String deleted;
  String date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    startTime: DateTime.parse(json["start_time"]),
    endTime: DateTime.parse(json["end_time"]),
    milestoneId: json["milestone_id"],
    description: json["description"],
    documents: json["documents"],
    empComplete: json["emp_complete"],
    completeDate: json["complete_date"],
    lateSubmitted: json["late_submitted"],
    status: json["status"],
    deleted: json["deleted"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "start_time": "${startTime.year.toString().padLeft(4, '0')}-${startTime.month.toString().padLeft(2, '0')}-${startTime.day.toString().padLeft(2, '0')}",
    "end_time": "${endTime.year.toString().padLeft(4, '0')}-${endTime.month.toString().padLeft(2, '0')}-${endTime.day.toString().padLeft(2, '0')}",
    "milestone_id": milestoneId,
    "description": description,
    "documents": documents,
    "emp_complete": empComplete,
    "complete_date": completeDate,
    "late_submitted": lateSubmitted,
    "status": status,
    "deleted": deleted,
    "date": date,
  };
}
