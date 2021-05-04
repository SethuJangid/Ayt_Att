import 'dart:convert';

import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:AYT_Attendence/model/EarlyCheck_IN_OUT_Model.dart';
import 'package:flutter/material.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'EarlyCheckOutUpload.dart';

class EarlyCheckOutRequest extends StatefulWidget {
  String unique_id;
  EarlyCheckOutRequest({this.unique_id});
  @override
  EarlyCheckOutRequestState createState() => EarlyCheckOutRequestState();
}

class EarlyCheckOutRequestState extends State<EarlyCheckOutRequest> {


  @override
  void initState() {
    super.initState();
    getData();
  }

  String reporter_id;
  String reporter_leave_id;
  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {

      reporter_id = sharedPreferences.getString("reporter_id");
      reporter_leave_id = sharedPreferences.getString("reporter_leave_id");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppConfig.appColorMain,
          title: Container(
            margin: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
            child: Text(
              'Early CheckOut List',
              style: TextStyle(color: AppConfig.appBarTextColor),
            ),
          ),
        ),
        body: FutureBuilder<EarlyCheckInOutModel>(
            future: earlyMarkMethod(),
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
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.data.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        int status2 = int.parse(snapshot.data.data[index].status);
                        var list = snapshot.data.data[index];
                        var dateSplit = list.date.split(' ').toList();
                        var date = dateSplit[0].trim();
                        return
                            status2 == 0
                            ? Card(
                          elevation: 8,
                          child: ExpansionCard(
                            title: Container(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(right: 8.0),
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
                                  Row(
                                    children: [
                                      Padding(padding: EdgeInsets.all(4.0),
                                      child:Text(
                                        "Date : "+date,
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400),
                                      ),)

                                    ],
                                  ),
                                ],
                              ),
                            ),
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 7),
                                child: Text(list.reasion,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black,fontWeight: FontWeight.w400)),
                              )
                            ],
                          ),
                        )
                            : status2 == 1
                            ? Card(
                          elevation: 8,
                          child: ExpansionCard(
                            title: Container(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(right: 8.0),
                                    decoration: new BoxDecoration(
                                        border: new Border(
                                            right: new BorderSide(
                                                width: 5.0,
                                                color: AppConfig.appColorMain))),
                                    child: Image.asset(
                                      "assets/pending_ap.png",
                                      height: 70,
                                      width: 60,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(padding: EdgeInsets.all(4.0),
                                        child :Text(
                                        "Date : "+date,
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                            children: <Widget>[
                              Container(
                                margin:
                                EdgeInsets.symmetric(horizontal: 7,vertical: 5),
                                child: Text(list.reasion,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,fontWeight: FontWeight.w400)),
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
                        )
                            : status2 == 2
                            ? Card(
                          elevation: 8,
                          child: ExpansionCard(
                            title: Container(
                              child: Row(
                                children: [
                                  Container(
                                    padding:
                                    EdgeInsets.only(right: 8.0),
                                    decoration: new BoxDecoration(
                                        border: new Border(
                                            right: new BorderSide(
                                                width: 5.0,
                                                color: Colors.green))),
                                    child: Image.asset(
                                      "assets/approved_ap.png",
                                      height: 70,
                                      width: 60,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        "Date : "+date,
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black54,
                                            fontWeight:
                                            FontWeight.w400),
                                      ),),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 7,vertical: 5),
                                child: Text(list.reasion,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight:
                                        FontWeight.w400)),
                              )
                            ],
                          ),
                        )
                            : Card(
                          elevation: 8,
                          child: ExpansionCard(
                            title: Container(
                              child: Row(
                                children: [
                                  Container(
                                    padding:
                                    EdgeInsets.only(right: 12.0),
                                    decoration: new BoxDecoration(
                                        border: new Border(
                                            right: new BorderSide(
                                                width: 5.0,
                                                color: Colors.red))),
                                    child: Image.asset(
                                      "assets/ayt.png",
                                      height: 60,
                                      width: 50,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Row(
                                    children: [

                                      Text(
                                        "Date : "+date,
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black54,
                                            fontWeight:
                                            FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 7),
                                child: Text(list.reasion,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black)),
                              )
                            ],
                          ),
                        );
                      },
                    );
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
                MaterialPageRoute(builder: (context) => EarlyCheckOutUpload(unique_id: widget.unique_id,)));
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

  Future<EarlyCheckInOutModel> earlyMarkMethod() async {
    var endpointUrl = All_API().baseurl + All_API().api_mark_early;
    Map<String, String> queryParameter = {
      'id': widget.unique_id,
    };
    String queryString = Uri(queryParameters: queryParameter).query;
    var requestUrl = endpointUrl + '?' + queryString;

    var response = await http.get(requestUrl, headers: {
      All_API().key: All_API().keyvalue,
    });
    print("Mark Early URL---> " + requestUrl);
    print("Mark Early Status Code--> " + response.statusCode.toString());
    if (response.statusCode == 200) {
      var jasonDataNotification = jsonDecode(response.body);
      String msg = jasonDataNotification['msg'];
      //_showToast(context, msg);
      print("Mark Early Response--> " + response.body);
      return EarlyCheckInOutModel.fromJson(jasonDataNotification);
    } else {
      //_showToast(context, msg);
    }
  }

  void _showToast(BuildContext context, String msg) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(""),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
            label: msg != null ? msg : "",
            textColor: Colors.white,
            onPressed: scaffold.hideCurrentSnackBar),
      ),
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
}
