import 'package:flutter/widgets.dart';

class AppConfig {
  static Color appColorMain = Color(0xff001741) ;
  static Color appBarTextColor = Color(0xfff59506) ;
  static Color appColorMainLight = Color(0xff466bc9) ;
  static Color appColorSecond = Color(0xff012a92) ;
  static Color fontColor = Color(0xff030303) ;
  static Color buttonColor = Color(0xfff59506) ;
  static Color textColor = Color(0xffeef0f3) ;
  static Color iconColor = Color(0xfff6f4f2) ;
  static Color colorWhite = Color(0xfff6f4f2) ;
  static Color colorBlack = Color(0xff020202) ;
  static Color iconColorDefault = Color(0xff0d8bec) ;
  static Color snackBarIFColor = Color(0xff3fcb03) ;
  static Color snackBarELSEColor = Color(0xfff10317) ;
  static Color fixedBarColor = Color(0xFFFFE0B2) ;

  static Color fixedCardColor = Color(0xFFFAF6F0) ;
  static Color fixedCardColor2 = Color(0xFFF5E0C0) ;

  static Color lowColor = Color(0xff001741) ;
  static Color highColor = Color(0xFF255703) ;
  static Color urgentColor = Color(0xFFC70116) ;
  static Color mediumColor = Color(0xFFEAD304) ;
  /////////////
  static String appIcon ;
  static String appIconDefault = "assets/payroll_app_icon.png";

  static String mediaIcon = "https://www.pinclipart.com/picdir/middle/126-1266771_post-page-to-add-pictures-comments-add-post.png";

  static String iconPending = "assets/pending_ap.png";
  static String iconReject = "assets/rejected_ap.png";
  static String iconApproved = "assets/approved_ap.png";

  static String generalTaskIcon = "https://spng.pngfind.com/pngs/s/276-2766443_png-file-svg-new-task-icon-png-transparent.png";
  static String projectTaskIcon = "https://www.pngitem.com/pimgs/m/191-1916857_project-management-icon-transparent-project-management-icon-png.png";

  static String noDataIconDefault = "https://www.mydiscountshop.in/assets/front/images/record-not-found.png";
  static String userIconDefault = "https://images-na.ssl-images-amazon.com/images/I/41ONa5HOwfL._SX425_.jpg";
  static String bannerImageDefault = "https://www.designwizard.com/wp-content/uploads/2019/02/71d785d0-2fa5-11e9-88e7-434a8ab53baf.jpg";
  static String birthImageDefault = "https://www.pngfind.com/pngs/m/121-1210530_happy-birthday-calligraphy-transparent-png-clear-background-happy.png";
  static String newsImageDefault = "https://image.freepik.com/free-vector/news-production-flat-color-illustration-professional-anchorman-cameraman-2d-cartoon-characters-with-studio-background_151150-2452.jpg";
  //////////
  static String welcome = "WelCome ";
  static String appName;
  static String appNameDefault = "ATTENDANCE APP";

  static String appUserNameDefault = "User";
  static String appUserEmployeeIDDefault = "User";
  static String appUserDepartmentDefault = "Android Development";
  static String appUserEmailDefault = "exapmle@gmail.com";
  static String appUserPhoneDefault = "1234567890";
  static String appUserDesignationDefault = "Software Engineer";
  static String appUserDOBDefault = "01/01/2000";
  static String appUserJDDefault = "01/01/2020";

  static List defaultLeaveList = [
    {"leave_id": 1, "leave_type": "No Leave", "total_allowd": 0, "total_used": 0, "total_unused": 5},
  ];


  void init(BuildContext context){

  }
}