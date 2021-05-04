import 'dart:convert';

import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:http/http.dart' as http;

class EarlyCheckOutUpload extends StatefulWidget {
  String unique_id;
  EarlyCheckOutUpload({this.unique_id});
  @override
  EarlyCheckOutUploadState createState() => EarlyCheckOutUploadState();
}

class EarlyCheckOutUploadState extends State<EarlyCheckOutUpload> {
  TextEditingController _textEditingController = TextEditingController();

  String reason;
  FocusNode focusNode = new FocusNode();

  @override
  void initState(){
    super.initState();
    getData();
  }
  getData()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppConfig.appColorMain,
          title: Container(
            margin: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
            child: Text(
              'Early CheckOut Request',
              style: TextStyle(color: AppConfig.appBarTextColor),
            ),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('WRITE YOUR EARLY CHECKOUT CAUSE',
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                autofocus: false,
                controller: _textEditingController,
                keyboardType: TextInputType.multiline,
                scrollPadding:const EdgeInsets.all(20.0),
                scrollPhysics: AlwaysScrollableScrollPhysics(),
                autocorrect: true,
                textInputAction: TextInputAction.newline,
                maxLines: 15,
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field cannot be left empty';
                  }
                },
                decoration: new InputDecoration(
                    labelText: 'Reason',
                    border: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(10.0)
                    )
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          buttonBackgroundColor: AppConfig.buttonColor,
          height: 50.0,
          color: Colors.blue[1000],
          index: 0,
          backgroundColor: AppConfig.textColor,
          items: [
            Icon(Icons.check, size: 30),
          ],
          onTap: (index) {
            //Handle button tap
            setState(() {
              reason=_textEditingController.text;
              earlyMarkMethod(widget.unique_id,reason,context);
            });
          },
        ),
      ),
    );
  }
  void earlyMarkMethod(String id,String reason2,BuildContext context) async {
    var endpointUrl = All_API().baseurl + All_API().api_mark_early;
    print("Mark Early--> " + endpointUrl);
    String body =jsonEncode({"employee_id":id, "reasion": reason2});
    var response = await http.post(endpointUrl, body:body , headers: {
      All_API().key: All_API().keyvalue,
    });
    print("Mark Early Response--> " + response.body);
    var jsonData = jsonDecode(response.body);
    String msg=jsonData['msg'];
    if (response.statusCode == 200) {
      print("Mark if Response--> " + jsonData);
      setState(() {
        FocusScope.of(context).requestFocus(focusNode);
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(
            msg),backgroundColor: Colors.green,));
        /*final snackBar = SnackBar(content: Text(msg,style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.red,);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
      });

    }
    else{
      print("Mark else Response--> " + msg);
      setState(() {
        FocusScope.of(context).requestFocus(focusNode);
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(
            msg),backgroundColor: Colors.red,));
       /* final snackBar = SnackBar(content: Text(msg,style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.red,);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
      });
    }
  }
  void _showToast(BuildContext context,String msg) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(""),
        behavior:SnackBarBehavior.floating ,
        action: SnackBarAction(
            label: msg!=null?msg:"",
            textColor: Colors.white, onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}