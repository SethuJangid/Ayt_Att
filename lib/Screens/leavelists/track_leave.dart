import 'dart:convert';

import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Screens/leavelists/leave_application.dart';
import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:AYT_Attendence/Screens/leavelists/model/TrackLeaveModel.dart';

class MyTrackLeave extends StatefulWidget {
  String unique_id;
  MyTrackLeave({this.unique_id});
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyTrackLeave> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  String uniqID2;
  String reporter_id;
  String reporter_leave_id;
  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
        uniqID2 = sharedPreferences.getString("unique_id");

        reporter_id = sharedPreferences.getString("reporter_id");
        reporter_leave_id = sharedPreferences.getString("reporter_leave_id");
    });
  }

  Future<TrackLeaveModel> loadStudent() async {
    //var endpointUrl ="http://adiyogitechnosoft.com/attendance_dev/api/leave/NODS5X5N5V2H2Z";
    var endpointUrl =
        All_API().baseurl + All_API().api_apply_leave + widget.unique_id;
    print("NotificationUrl--> " + endpointUrl);
    try {
      var response = await http.get(endpointUrl, headers: {
        All_API().key: All_API().keyvalue,
      });
      print("TrackLeaveResponse--> " + response.body);
      var jasonDataNotification = jsonDecode(response.body);
      var msg = jasonDataNotification['msg'];
      if (response.statusCode == 200) {
        return TrackLeaveModel.fromJson(jasonDataNotification);
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(
            msg),backgroundColor: Colors.green,));
        /*final snackBar = SnackBar(
          content: Text(
            msg,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
      }
    } catch (Exception) {
      return Exception;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppConfig.appColorMain,
          title: Container(
            margin: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
            child: Text(
              'Track Leave',
              style: TextStyle(color: AppConfig.appBarTextColor),
            ),
          ),
        ),
        body: FutureBuilder<TrackLeaveModel>(
                  future: loadStudent(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text('none');
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.active:
                        return Text('');
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          return widget.unique_id!=uniqID2?ListView.builder(
                              itemCount: snapshot.data.data.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                int status =
                                int.parse(snapshot.data.data[index].status);
                                var notificationlist =
                                snapshot.data.data[index];
                                var strFrom =
                                notificationlist.fromDate.toString();
                                var StrdateFrom = strFrom.split(" ");
                                var dateFrom = StrdateFrom[0].trim();
                                /////
                                var strTo = notificationlist.toDate.toString();
                                var StrdateTo = strTo.split(" ");
                                var dateTo = StrdateTo[0].trim();
                                return status == 0
                                    ? Card(
                                  elevation: 8.0,
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                        // topRight: Radius.circular(10.0),
                                        // bottomRight: Radius.circular(10.0),
                                        // topLeft: Radius.circular(10.0),
                                        // bottomLeft: Radius.circular(10.0),
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(
                                        top: 5,
                                        left: 5,
                                        bottom: 5,
                                        right: 5),
                                    child: ListTile(
                                      contentPadding:
                                      EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 10.0),
                                      leading: Container(
                                        padding:
                                        EdgeInsets.only(right: 12.0),
                                        decoration: new BoxDecoration(
                                            border: new Border(
                                                right: new BorderSide(
                                                    width: 5.0,
                                                    color: Colors.red))),
                                        child: Image.asset(
                                          "assets/rejected_ap.png",
                                          height: 70,
                                          width: 60,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      title: Padding(
                                        padding:
                                        const EdgeInsets.all(2.0),
                                        child: Text(
                                          notificationlist.name
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.orange,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ),
                                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                      subtitle: Column(
                                        children: <Widget>[
                                          Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black54),
                                              children: [
                                                TextSpan(
                                                  text: '$dateFrom',
                                                ),
                                                WidgetSpan(
                                                  child: Icon(
                                                      Icons
                                                          .arrow_right_sharp,
                                                      color:
                                                      Colors.black54),
                                                ),
                                                TextSpan(
                                                  text: '$dateTo',
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      // trailing:
                                      //  Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white, size: 30.0)),
                                    ),
                                  ),
                                )
                                    : status == 1
                                    ? Card(
                                  elevation: 8.0,
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical: 6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                        // topRight: Radius.circular(10.0),
                                        // bottomRight: Radius.circular(10.0),
                                        // topLeft: Radius.circular(10.0),
                                        // bottomLeft: Radius.circular(10.0),
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(
                                        top: 5,
                                        left: 5,
                                        bottom: 5,
                                        right: 5),
                                    child: ListTile(
                                      contentPadding:
                                      EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 10.0),
                                      leading: Container(
                                        padding: EdgeInsets.only(
                                            right: 12.0),
                                        decoration: new BoxDecoration(
                                            border: new Border(
                                                right: new BorderSide(
                                                    width: 5.0,
                                                    color: AppConfig.appColorMain)
                                            )
                                        ),
                                        child: Image.asset(
                                          "assets/pending_ap.png",
                                          height: 70,
                                          width: 60,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      title: Padding(
                                        padding:
                                        const EdgeInsets.all(2.0),
                                        child: Text(
                                          notificationlist.name
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.orange,
                                              fontWeight:
                                              FontWeight.w200),
                                        ),
                                      ),
                                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                      subtitle: Column(
                                        children: <Widget>[
                                          Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color:
                                                  Colors.black54),
                                              children: [
                                                TextSpan(
                                                  text: '$dateFrom',
                                                ),
                                                WidgetSpan(
                                                  child: Icon(
                                                      Icons
                                                          .arrow_right_sharp,
                                                      color: Colors
                                                          .black54),
                                                ),
                                                TextSpan(
                                                  text: '$dateTo',
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 20,),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                                                child: new RaisedButton(
                                                  color: AppConfig.buttonColor,
                                                  child: Text(
                                                    'Accept',
                                                    style: TextStyle(
                                                      color: AppConfig.appColorMain,
                                                    ),
                                                  ),
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(18.0),
                                                      side: BorderSide(color: AppConfig.appColorMain)
                                                  ),
                                                  // padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                                                  splashColor: AppConfig.appColorMain,
                                                  onPressed: (){
                                                    _showDialog(context,reporter_leave_id,reporter_id,"approve");
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                                                child: RaisedButton(
                                                  child: Text(
                                                    'Reject',
                                                    style: TextStyle(
                                                      color: AppConfig.appColorMain,
                                                    ),
                                                  ),
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(18.0),
                                                      side: BorderSide(color: AppConfig.appColorMain)
                                                  ),
                                                  // padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                                                  splashColor: AppConfig.appColorMain,
                                                  onPressed: (){
                                                    _showDialog(context,reporter_leave_id,reporter_id,"reject");
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                    : Card(
                                  elevation: 8.0,
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical: 6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white54,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                        // topRight: Radius.circular(10.0),
                                        // bottomRight: Radius.circular(10.0),
                                        // topLeft: Radius.circular(10.0),
                                        // bottomLeft: Radius.circular(10.0),
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(
                                        top: 5,
                                        left: 5,
                                        bottom: 5,
                                        right: 5),
                                    child: ListTile(
                                      contentPadding:
                                      EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 10.0),
                                      leading: Container(
                                        padding: EdgeInsets.only(
                                            right: 12.0),
                                        decoration: new BoxDecoration(
                                            border: new Border(
                                                right: new BorderSide(
                                                    width: 5.0,
                                                    color: Colors
                                                        .green))),
                                        child: Image.asset(
                                          "assets/approved_ap.png",
                                          height: 70,
                                          width: 60,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      title: Padding(
                                        padding:
                                        const EdgeInsets.all(2.0),
                                        child: Text(
                                          notificationlist.name
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.orange,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ),
                                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                      subtitle: Column(
                                        children: <Widget>[
                                          Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color:
                                                  Colors.black54),
                                              children: [
                                                TextSpan(
                                                  text: '$dateFrom',
                                                ),
                                                WidgetSpan(
                                                  child: Icon(
                                                      Icons
                                                          .arrow_right_sharp,
                                                      color: Colors
                                                          .black54),
                                                ),
                                                TextSpan(
                                                  text: '$dateTo',
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      // trailing:
                                      //  Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white, size: 30.0)),
                                    ),
                                  ),
                                );
                              }):
                          ListView.builder(
                              itemCount: snapshot.data.data.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                int status =
                                int.parse(snapshot.data.data[index].status);
                                var notificationlist =
                                snapshot.data.data[index];
                                var strFrom =
                                notificationlist.fromDate.toString();
                                var StrdateFrom = strFrom.split(" ");
                                var dateFrom = StrdateFrom[0].trim();
                                /////
                                var strTo = notificationlist.toDate.toString();
                                var StrdateTo = strTo.split(" ");
                                var dateTo = StrdateTo[0].trim();
                                return status == 0
                                    ? Card(
                                  elevation: 8.0,
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                        // topRight: Radius.circular(10.0),
                                        // bottomRight: Radius.circular(10.0),
                                        // topLeft: Radius.circular(10.0),
                                        // bottomLeft: Radius.circular(10.0),
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(
                                        top: 5,
                                        left: 5,
                                        bottom: 5,
                                        right: 5),
                                    child: ListTile(
                                      contentPadding:
                                      EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 10.0),
                                      leading: Container(
                                        padding:
                                        EdgeInsets.only(right: 12.0),
                                        decoration: new BoxDecoration(
                                            border: new Border(
                                                right: new BorderSide(
                                                    width: 5.0,
                                                    color: Colors.red))),
                                        child: Image.asset(
                                          "assets/rejected_ap.png",
                                          height: 70,
                                          width: 60,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      title: Padding(
                                        padding:
                                        const EdgeInsets.all(2.0),
                                        child: Text(
                                          notificationlist.name
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.orange,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ),
                                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                      subtitle: Column(
                                        children: <Widget>[
                                          Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black54),
                                              children: [
                                                TextSpan(
                                                  text: '$dateFrom',
                                                ),
                                                WidgetSpan(
                                                  child: Icon(
                                                      Icons
                                                          .arrow_right_sharp,
                                                      color:
                                                      Colors.black54),
                                                ),
                                                TextSpan(
                                                  text: '$dateTo',
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      // trailing:
                                      //  Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white, size: 30.0)),
                                    ),
                                  ),
                                )
                                    : status == 1
                                    ? Card(
                                  elevation: 8.0,
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical: 6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                        // topRight: Radius.circular(10.0),
                                        // bottomRight: Radius.circular(10.0),
                                        // topLeft: Radius.circular(10.0),
                                        // bottomLeft: Radius.circular(10.0),
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(
                                        top: 5,
                                        left: 5,
                                        bottom: 5,
                                        right: 5),
                                    child: ListTile(
                                      contentPadding:
                                      EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 10.0),
                                      leading: Container(
                                        padding: EdgeInsets.only(
                                            right: 12.0),
                                        decoration: new BoxDecoration(
                                            border: new Border(
                                                right: new BorderSide(
                                                    width: 5.0,
                                                    color: AppConfig.appColorMain)
                                            )
                                        ),
                                        child: Image.asset(
                                          "assets/pending_ap.png",
                                          height: 70,
                                          width: 60,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      title: Padding(
                                        padding:
                                        const EdgeInsets.all(2.0),
                                        child: Text(
                                          notificationlist.name
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.orange,
                                              fontWeight:
                                              FontWeight.w200),
                                        ),
                                      ),
                                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                      subtitle: Column(
                                        children: <Widget>[
                                          Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color:
                                                  Colors.black54),
                                              children: [
                                                TextSpan(
                                                  text: '$dateFrom',
                                                ),
                                                WidgetSpan(
                                                  child: Icon(
                                                      Icons
                                                          .arrow_right_sharp,
                                                      color: Colors
                                                          .black54),
                                                ),
                                                TextSpan(
                                                  text: '$dateTo',
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      // trailing:
                                      //  Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white, size: 30.0)),
                                    ),
                                  ),
                                )
                                    : Card(
                                  elevation: 8.0,
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical: 6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white54,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                        // topRight: Radius.circular(10.0),
                                        // bottomRight: Radius.circular(10.0),
                                        // topLeft: Radius.circular(10.0),
                                        // bottomLeft: Radius.circular(10.0),
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(
                                        top: 5,
                                        left: 5,
                                        bottom: 5,
                                        right: 5),
                                    child: ListTile(
                                      contentPadding:
                                      EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 10.0),
                                      leading: Container(
                                        padding: EdgeInsets.only(
                                            right: 12.0),
                                        decoration: new BoxDecoration(
                                            border: new Border(
                                                right: new BorderSide(
                                                    width: 5.0,
                                                    color: Colors
                                                        .green))),
                                        child: Image.asset(
                                          "assets/approved_ap.png",
                                          height: 70,
                                          width: 60,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      title: Padding(
                                        padding:
                                        const EdgeInsets.all(2.0),
                                        child: Text(
                                          notificationlist.name
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.orange,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ),
                                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                      subtitle: Column(
                                        children: <Widget>[
                                          Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color:
                                                  Colors.black54),
                                              children: [
                                                TextSpan(
                                                  text: '$dateFrom',
                                                ),
                                                WidgetSpan(
                                                  child: Icon(
                                                      Icons
                                                          .arrow_right_sharp,
                                                      color: Colors
                                                          .black54),
                                                ),
                                                TextSpan(
                                                  text: '$dateTo',
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      // trailing:
                                      //  Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white, size: 30.0)),
                                    ),
                                  ),
                                );
                              });
                        } else
                          return Center(
                            child: Card(
                              color: Colors.blue[1000],
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  All_API().two_error_occurred,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.orange,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                    }
                  }),


        floatingActionButton: FloatingActionButton(
          backgroundColor: AppConfig.appColorMain,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LeaveApplication()));
          },
          tooltip: "Add Early Checkout",
          child: Icon(
            Icons.add,
            color: Colors.orange,
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context,String id,String reporterID,String action,) {
    // flutter defined function
    String reason;
    TextEditingController textEditingController = new TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
                "Leave Update",
                style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.bold, color: Colors.orange),
              )),
          content: TextField(
            controller: textEditingController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: 'Enter Reason',
              hintStyle: TextStyle(
                fontSize: 16,
                color: Color(0xFF3F3C31),
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.1),
              contentPadding:
              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            Container(
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10.0),
                    child: RaisedButton(
                        color: Colors.orange,
                        onPressed: () {
                          reason = textEditingController.text;
                          updateLeave(context,id,reporterID,action,reason);
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Update",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: RaisedButton(
                        color: Colors.orange,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Close",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        )),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );

  }
  void updateLeave(BuildContext context,String id,String reporterID,String action,String reason) async{
    var headers = {
      'X-API-KEY': 'NODN2D0I7W4V8I2K',
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=5fj7t7hr4rbst62dknv9hd3nd52dcf63'
    };
    var request = http.Request('GET', Uri.parse(All_API().baseurl+All_API().api_report_leave));
    request.body = '''{"id":"$id","reporter_id":"$reporterID","action":"$action","message":"$reason"}''';
    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    Map json = jsonDecode(response.body);
    print("Update Reporter List----->" +response.body);

    if (response.statusCode == 200) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
            'Leave Request Successfully!!'),
        backgroundColor: Colors.green,
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content:
      Text(
          'Leave Request UnSuccessful'),
        backgroundColor: Colors.red,
      ));
    }
  }
}
