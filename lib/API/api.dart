// ignore: camel_case_types
import 'dart:io';

class All_API {
  @override
  noSuchMethod(Invocation invocation) async{
    // TODO: implement noSuchMethod
    return super.noSuchMethod(invocation);
  }
  final four_error_occurred="Something Error Found";
  final two_error_occurred="No Data Found! ";
  final error_occurred="Server Side Error";
  final key = 'x-api-key';
  final keyvalue = 'NODN2D0I7W4V8I2K';
  final FcmId ="NODN2D0I7W4V8I2K";
  final employee_ID="";
  final uniq_ID="";
  final slider_img_path ="uploads/slider/";
  final employee_expense_img_path ="/uploads/employee_expense/";
  final news_img_path ="/uploads/news/";
  final profile_img_path ="/uploads/employee/";

  //String baseurl="https://technolite.in/hrpayroll/api/";
  String baseurl="http://hrpayroll.technolite.in/ayt/api/";
  //String baseurl_img="https://technolite.in/hrpayroll";
  String baseurl_img="http://hrpayroll.technolite.in/ayt";

  String api_tack_dashboard= "employee/track_dashboard/";
  String api_login= "employee/employee_login";

  String api_mark_early= "mark_early";

  // ignore: non_constant_identifier_names
  String api_otp_verify="employee/verify_otp";

  // ignore: non_constant_identifier_names
  String api_news="news";

  // ignore: non_constant_identifier_names
  String api_birthday="employee/birthday";

  // ignore: non_constant_identifier_names
  String api_attendance= "/employee/employee_attandance";

  // ignore: non_constant_identifier_names
  String api_leave_type="leave/leaves_date_type/";

  // ignore: non_constant_identifier_names
  String api_slider="slider";

  // ignore: non_constant_identifier_names
  String api_track_attendance="employee/attandance_report/";

  // ignore: non_constant_identifier_names
  String api_department="department/";

  // ignore: non_constant_identifier_names
  String api_designation="designation/";

  // ignore: non_constant_identifier_names
  String api_general_leaves="general_leave";

  // ignore: non_constant_identifier_names
  String api_profile="employee/profile_image/";

  // ignore: non_constant_identifier_names
  String api_apply_leave="leave/";

  // ignore: non_constant_identifier_names
  String api_leave_spinner="leave/leaves_date_type/";

  // ignore: non_constant_identifier_names
  String api_about_us="settings/";

  // ignore: non_constant_identifier_names
  String api_privacy_policy="settings/";

  // ignore: non_constant_identifier_names
  String api_tearm_condition="settings/";

  // ignore: non_constant_identifier_names
  String api_contact_us_="settings/";

  // ignore: non_constant_identifier_names
  String api_notification ="notification/";

  // ignore: non_constant_identifier_names
  String api_salary_list="salary/";

  // ignore: non_constant_identifier_names
  String api_salary_detail="salary/salary_all_detail/";

  // ignore: non_constant_identifier_names
  String api_type_expense_list="expense";

// ignore: non_constant_identifier_names
  String api_expense_list="employee_expense/";

// ignore: non_constant_identifier_names
  String api_upload_expense="employee_expense";

  String api_task_list = "task/task_get_by_id/";

  String api_general_task="general_task";
  String api_general_task_upload="general_task/emp_request_task_complete";

  String api_project_task="project";
  String api_project_task_upload="api/task/emp_task_complete";

  String api_milestone_list="milestone/milestones_get_by_id/";


  String api_report_list="employee/employee_by_reporter_id/";
  String api_report_leave="leave/leave_status_update";

  // ignore: non_constant_identifier_names
  String api_update_expense="employee_expense/employee_expense_update";
}