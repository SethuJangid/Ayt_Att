import 'dart:convert';
import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:AYT_Attendence/model/TrackDashboardModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class EaelyCheck_IN_OUT extends StatefulWidget {
  @override
  leaveFeedState createState() => leaveFeedState();
}
class leaveFeedState extends State<EaelyCheck_IN_OUT> {
  String name;
  String date;
  String uniqID;
  String latitude;
  String longitude;
  String action;
  String address;
  String device;
  String action_check;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    trackdashStudent();
  }
  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString("name");
      uniqID = sharedPreferences.getString("unique_id");
      latitude = sharedPreferences.getString("lat");
      longitude = sharedPreferences.getString("long");
      action = sharedPreferences.getString("");
      address = sharedPreferences.getString("address");
      device = sharedPreferences.getString("device_id");
      print("UNIQ ID --->" + uniqID);
    });
  }
  Future<TrackDashboardModel> trackdashStudent() async {
    String device_id = device;
    String unique_id = uniqID;
    var endpointUrl = All_API().baseurl +
        All_API().api_tack_dashboard +
        unique_id +
        "/" +
        device_id;
    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
    };
    Map<String, String> queryParameter = {
      'latitute': latitude,
      'longitute': longitude,
    };
    String queryString = Uri(queryParameters: queryParameter).query;
    var requestUrl = endpointUrl + '?' + queryString;
    print(requestUrl);
    var response = await http.get(requestUrl, headers: headers);
    Map jasonData = jsonDecode(response.body);
    print('EarlyCheckInOut : ' + jasonData.toString());
    if(response.statusCode==200){
      //latecheckIN = jasonData['data'][0]['counterRecord'][0]['early_checkout'];
      //earlycheckOUT = jasonData['data'][0]['counterRecord'][0]['total_early_checkout'];
      //var latecheckin = jasonData['data'][0]['counterRecord'][2]['late_checkin'];
      //var earlycheckout = jasonData['data'][0]['counterRecord'][3]['early_checkout'];
      // var uniqId = jasonData['data'][0]['unique_id'];
      // var useruniqId = jasonData['data'][0]['user_unique_id'];
      print('EarlyCheckInOut : ' + jasonData.toString());
      //print(latecheckIN.toString()+' latecheckIN : ' + earlycheckOUT.toString());//+" "+earlycheckOUT);//+" "+latecheckin+" "+earlycheckout);
      return TrackDashboardModel.fromJson(jasonData);
    }
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TrackDashboardModel>(
      future: trackdashStudent(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var totalLatAllow;
          var totalearlyAllow;
          var totalLetUse;
          var totalEarlyUse;
          for(int index=0; snapshot.data.data.length>index; index++){
            snapshot.data.data[index].counterRecord.forEach((element) {
              totalLatAllow = element.totalLateCheckin.toString();
              totalearlyAllow = element.totalEarlyCheckout.toString();
            });
            snapshot.data.data[index].counterRecord.forEach((element) {
              totalLetUse = element.lateCheckin.toString();
              totalEarlyUse = element.earlyCheckout.toString();
            });
            return Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(
                      color: Colors.orange, // red as border color
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white54,
                          offset: Offset(0, 5),
                          blurRadius: 10.0),
                      BoxShadow(
                          color: Colors.white60,
                          offset: Offset(0, 5),
                          blurRadius: 10.0)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(totalLetUse==null?'0':totalLetUse,
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "USED",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                              child: Text(
                                "   Late CheckIn",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.all(5.0),
                                  child: Center(
                                      child: Text(
                                        totalLatAllow==null?'0':totalLatAllow,
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight:
                                            FontWeight.w600),
                                      )),
                                ),
                                Center(
                                    child: Text(
                                      "ALLOWED",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight:
                                          FontWeight.bold),
                                    ))
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(
                      color: Colors.orange, // red as border color
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white54,
                          offset: Offset(0, 5),
                          blurRadius: 10.0),
                      BoxShadow(
                          color: Colors.white60,
                          offset: Offset(0, 5),
                          blurRadius: 10.0)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(totalEarlyUse==null?'0':totalEarlyUse,
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "USED",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 3),
                              child: Text(
                                "Early CheckOut",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.all(5.0),
                                  child: Center(
                                      child: Text(
                                        totalearlyAllow==null?'0':totalearlyAllow,
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight:
                                            FontWeight.w600),
                                      )),
                                ),
                                Center(
                                    child: Text(
                                      "ALLOWED",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight:
                                          FontWeight.bold),
                                    ))
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return null;
        } else if (snapshot.hasData == false) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  border: Border.all(
                    color: Colors.orange, // red as border color
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white54,
                        offset: Offset(0, 5),
                        blurRadius: 10.0),
                    BoxShadow(
                        color: Colors.white60,
                        offset: Offset(0, 5),
                        blurRadius: 10.0)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text('0',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "USED",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                            child: Text(
                              "   Late CheckIn",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.all(5.0),
                                child: Center(
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight:
                                          FontWeight.w600),
                                    )),
                              ),
                              Center(
                                  child: Text(
                                    "ALLOWED",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                        fontWeight:
                                        FontWeight.bold),
                                  ))
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  border: Border.all(
                    color: Colors.orange, // red as border color
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white54,
                        offset: Offset(0, 5),
                        blurRadius: 10.0),
                    BoxShadow(
                        color: Colors.white60,
                        offset: Offset(0, 5),
                        blurRadius: 10.0)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text('0',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "USED",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 3),
                            child: Text(
                              "Early CheckOut",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.all(5.0),
                                child: Center(
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight:
                                          FontWeight.w600),
                                    )),
                              ),
                              Center(
                                  child: Text(
                                    "ALLOWED",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                        fontWeight:
                                        FontWeight.bold),
                                  ))
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        } else
          return Center(child: CircularProgressIndicator());
      },
    );

  }
}