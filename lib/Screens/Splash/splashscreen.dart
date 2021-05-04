import 'package:AYT_Attendence/Screens/LoginScreen/login2.dart';
import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:AYT_Attendence/sidebar/bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';


class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool logIN;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefance();
  }
  getPrefance()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      logIN=sharedPreferences.getBool('loggedIn');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SplashScreen(
          seconds: 5,
          backgroundColor: Colors.white,
          navigateAfterSeconds: logIN==true?BottomNavBar():MyLogin2(),
          loaderColor: AppConfig.appColorMain,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: ClipRRect(
                child: Image.asset(
                    AppConfig.appIcon==null?
                    AppConfig.appIconDefault:AppConfig.appIcon,
                  height: 200,
                  width: 200,
                  fit: BoxFit.fill,
                ),
              )
            ),
          ],
        ),
      ],
    );
  }
}





