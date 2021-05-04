import 'dart:async';
import 'dart:convert';

import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Screens/chat2/auth2.dart';
import 'package:AYT_Attendence/Screens/chat2/database.dart';
import 'package:AYT_Attendence/Screens/chat2/helperfunctions2.dart';
import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:AYT_Attendence/sidebar/image_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'EaelyCheck_IN_OUT.dart';
import 'birthdayFeed.dart';
import 'checkIN_OUT.dart';
import 'leaveFeed.dart';
import 'newsFeeds.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<Dashboard> {
  String path = All_API().baseurl_img + All_API().profile_img_path;
  String name;
  String userimg;
  String useremail;
  String userpassword;
  String date;
  String uniqID;
  String latitude;
  String longitude;
  String action;
  String address;
  String device;
  String action_check;

  String workingHour;
  String accuuracy;

  String _accuuracyPer;
  String _accuuracy_meter;
  String statuscode;
  String s1;
  String s2;
  AuthService2 authService = new AuthService2();
  DatabaseMethods2 databaseMethods = new DatabaseMethods2();
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString("name");
      userimg = sharedPreferences.getString("image");
      useremail = sharedPreferences.getString("email");
      print("email1-->" + useremail);
      userpassword = sharedPreferences.getString("password");
      print("PASSSSSS SIGNUP--->"+userpassword);

      uniqID = sharedPreferences.getString("unique_id");
      latitude = sharedPreferences.getString("lat");
      longitude = sharedPreferences.getString("long");
      action = sharedPreferences.getString("");
      address = sharedPreferences.getString("address");
      device = sharedPreferences.getString("device_id");
      showData(uniqID, device);
      String image = path + userimg;
      singUp(image);
    });
  }

  showData(String uniqID, String device) {
    trackdashStudent(uniqID, device);
  }

  signIn() async {
    print("EMAIL LOGIN--->" + useremail);
    print("PASSWORD LOGIN--->" + userpassword);
    await authService
        .signInWithEmailAndPassword(useremail, userpassword)
        .then((result) async {
      if (result != null) {
        QuerySnapshot userInfoSnapshot =
            await DatabaseMethods2().getUserInfo(useremail);
        HelperFunctions2.saveUserLoggedInSharedPreference(true);
        HelperFunctions2.saveUserNameSharedPreference(
            userInfoSnapshot.documents[0].data()["userName"]);
        HelperFunctions2.saveUserEmailSharedPreference(
            userInfoSnapshot.documents[0].data()["userEmail"]);
        /*Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));*/
      } else {
        setState(() {
          //isLoading = false;
          //show snackbar
        });
      }
    });
  }

  singUp(String image) async {
    print("EMAIL SIGNUP--->" + useremail);
    print("PASSWORD SIGNUP--->" + userpassword);
    try {
      await authService
          .signUpWithEmailAndPassword(useremail, userpassword)
          .then((result) {
        if (result != null) {
          Map<String, String> userDataMap = {
            "userName": name,
            "userEmail": useremail,
            "userImage": image,
          };
          print("Result---->" + result.toString());
          databaseMethods.addUserInfo(userDataMap);
          HelperFunctions2.saveUserLoggedInSharedPreference(true);
          HelperFunctions2.saveUserNameSharedPreference(name);
          HelperFunctions2.saveUserEmailSharedPreference(useremail);
          HelperFunctions2.saveUserImageSharedPreference(image);
          /*Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatRoom()
          ));*/
        }
      });
    } catch (signUpError) {
      QuerySnapshot userInfoSnapshot =
          await DatabaseMethods2().getUserInfo(useremail);
      final FirebaseAuth _auth = FirebaseAuth.instance;
      var email;
      for(int i=0; i< userInfoSnapshot.documents.length; i++){
        email = userInfoSnapshot.documents[i].data()["userEmail"];
        if (email == useremail) {
          signIn();
        }
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        child: RefreshIndicator(
          onRefresh: _refreshLocalGallery,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5,),
            child: Column(
              children: [
                ImageSlider(),
                SizedBox(height: 10,),
                Center(
                  child: Text(
                    name != null ? AppConfig.welcome+ name : AppConfig.welcome+AppConfig.appUserNameDefault,
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        color: AppConfig.fontColor),
                  ),
                ),
                SizedBox(height: 10,),
                EaelyCheck_IN_OUT(),
                SizedBox(height: 10,),
                leaveFeed(unique_id: uniqID,),
                SizedBox(height: 10,),
                checkIN_OUT(),
                SizedBox(height: 10,),
                Card(
                  color: AppConfig.fixedBarColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _accuuracyPer != null
                        ? Text(
                      'Your current location is accurate to $_accuuracy_meter Mtr,GPS accuracy level $_accuuracyPer',
                      style:
                      TextStyle(fontSize: 15, color: AppConfig.fontColor),
                    )
                        : Text(
                        "Your current location is accurate to 0.00Mtr,GPS accuracy level 0%"),
                  ),
                ),
                SizedBox(height: 10,),
                birthdayFeed(),
                SizedBox(height: 10,),
                newsFeeds(),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
    );
  }

  Future<Null> _refreshLocalGallery() async {
    print('refreshing stocks...');
  }

  Future trackdashStudent(String unique_id, String device_id) async {
    //String device_id='ASD852SD';
    print("UNIQ ID Dasboad--->" + uniqID);
    print("device ID Dasboad--->" + device);
    print("latitude ID Dasboad--->" + latitude);
    print("longitude ID Dasboad--->" + longitude);

    var endpointUrl = All_API().baseurl +
        All_API().api_tack_dashboard +
        unique_id +
        "/" +
        device_id;
    // var endpointUrl = All_API().baseurl+All_API().api_tack_dashboard +"NODK2J2S0N5Z5M8C5P3T4X"+"/"+"046b75822227087b";
    print("URL dash-->" + endpointUrl);
    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
    };
    Map<String, String> queryParameter = {
      'latitute': latitude,
      'longitute': longitude,
    };
    // Map<String, String>  queryParameter={
    //   'latitute':'26.2977743',
    //   'longitute':'73.0395951',
    // };
    String queryString = Uri(queryParameters: queryParameter).query;
    var requestUrl = endpointUrl + '?' + queryString;
    print("URLBody_dash-->" + requestUrl);
    var response = await http.get(requestUrl, headers: headers);
    statuscode = response.statusCode.toString();
    if (response.statusCode == 200) {
      setState(() {
        Map jasonData = jsonDecode(response.body);
        workingHour = jasonData['data'][0]['workRecord'][0]['difference_time'];
        _accuuracyPer =
            jasonData['data'][0]['locationRecord'][0]['accuracy_per'];
        _accuuracy_meter =
            jasonData['data'][0]['locationRecord'][0]['accuracy_meter'];
        print('Dassboard : ' + jasonData.toString());
        print('DassboardData : ' +
            workingHour +
            " " +
            _accuuracyPer +
            " " +
            _accuuracy_meter);
      });
    } else {
      /*final snackBar = SnackBar(
        content: Text(
          '!Error..Not Fetch Lat Long',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
      /*Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(
          'Your OTP is Not Correct'),backgroundColor: Colors.green,));*/
    }
  }
}
