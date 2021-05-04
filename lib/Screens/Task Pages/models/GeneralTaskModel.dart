import 'dart:convert';

GeneralTaskModel generalTaskModelFromJson(String str) => GeneralTaskModel.fromJson(json.decode(str));

String generalTaskModelToJson(GeneralTaskModel data) => json.encode(data.toJson());

class GeneralTaskModel {
  GeneralTaskModel({
    this.status,
    this.msg,
    this.path,
    this.data,
  });

  bool status;
  String msg;
  String path;
  List<Datum> data;

  factory GeneralTaskModel.fromJson(Map<String, dynamic> json) => GeneralTaskModel(
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
    this.description,
    this.documents,
    this.startTime,
    this.endTime,
    this.employeeId,
    this.priorityId,
    this.empComplete,
    this.completeDate,
    this.lateSubmitted,
    this.status,
    this.deleted,
    this.date,
  });

  String id;
  String name;
  String description;
  String documents;
  DateTime startTime;
  DateTime endTime;
  String employeeId;
  String priorityId;
  String empComplete;
  String completeDate;
  String lateSubmitted;
  String status;
  String deleted;
  String date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    documents: json["documents"],
    startTime: DateTime.parse(json["start_time"]),
    endTime: DateTime.parse(json["end_time"]),
    employeeId: json["employee_id"],
    priorityId: json["priority_id"],
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
    "description": description,
    "documents": documents,
    "start_time": "${startTime.year.toString().padLeft(4, '0')}-${startTime.month.toString().padLeft(2, '0')}-${startTime.day.toString().padLeft(2, '0')}",
    "end_time": "${endTime.year.toString().padLeft(4, '0')}-${endTime.month.toString().padLeft(2, '0')}-${endTime.day.toString().padLeft(2, '0')}",
    "employee_id": employeeId,
    "priority_id": priorityId,
    "emp_complete": empComplete,
    "complete_date": completeDate,
    "late_submitted": lateSubmitted,
    "status": status,
    "deleted": deleted,
    "date": date,
  };
}
