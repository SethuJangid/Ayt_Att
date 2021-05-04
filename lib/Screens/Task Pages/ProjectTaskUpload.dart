import 'dart:convert';
import 'dart:io';

import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ProjectTaskUpload extends StatefulWidget {
  String name;
  String task_id;
  ProjectTaskUpload({this.name,this.task_id});
  @override
  _GeneralTaskDetailPageState createState() => _GeneralTaskDetailPageState();
}

class _GeneralTaskDetailPageState extends State<ProjectTaskUpload> {
  TextEditingController textEditingController = TextEditingController();
  List<File> fileImageArray = List<File>();

  String uniqID;
  String description;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  getData()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      uniqID = sharedPreferences.getString("unique_id");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConfig.appColorMain,
        title: Padding(
            padding: const EdgeInsets.only(left: 6.0, top: 5.0),
            child: Text(
              "Project Task Upload",
              style: TextStyle(color: AppConfig.appBarTextColor),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    widget.name.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: AppConfig.appColorMain,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Description",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Divider(
                height: 1,
                color: AppConfig.appColorMain,
              ),
              Container(
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          child: TextFormField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                              hintText: "Enter Description",
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(0.0),
                                ),
                              ),
                            ),
                            maxLines: 300,
                          ),
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: 50,
              ),
              Divider(
                height: 1,
                color: AppConfig.appColorMain,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: GestureDetector(
                  onTap: () {
                    pickImages();
                  },
                  child: Card(
                    elevation: 8,
                    color: AppConfig.buttonColor,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("SELECT IMAGE",style: TextStyle(color: AppConfig.appColorMain),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.image,color: AppConfig.appColorMain,),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 300,
                child: GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(fileImageArray.length, (index) {
                    File asset = fileImageArray[index];
                    print("Assets---->" + asset.path);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        asset,
                        width: 300,
                        height: 300,
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: (){
          description = textEditingController.text;
          print("Employee ID---->"+uniqID);
          print("Description---->"+description);
          print("Task ID---->"+widget.task_id);
          profileUpload(uniqID,widget.task_id,context);
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppConfig.buttonColor,
            ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Upload ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        ),
      ),
    );
  }

  Future<void> pickImages() async {
    var imagepicker = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      print("profileUpload_imagepicker--> " + imagepicker.path);
      File uploadimage = imagepicker;
      fileImageArray.add(uploadimage);
    });
  }

  void profileUpload(String uniqId,String tskID,BuildContext context) async {
    print("Employee ID---->"+uniqId);
    print("Description---->"+description);
    print("Task ID---->"+tskID);
    var uri = Uri.parse(All_API().baseurl + All_API().api_project_task_upload);
    print("Task URL--->" + uri.toString());
    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
    };
    var request = http.MultipartRequest('POST', uri);
    // request.files.add(await http.MultipartFile.fromPath('file', uploadimage.path));
    for (int i = 0; i < fileImageArray.length; i++) {
      File file = fileImageArray[i];
      print("File Array lenght -----2-->" + fileImageArray.length.toString());
      final multipartFile =
          await http.MultipartFile.fromPath('image[]', file.path);
      print("file---> : " + file.toString());
      request.files.add(multipartFile);
    }

    request.headers.addAll(headers);
    request.fields.addAll({
      'employee_id': uniqId,
      'description': description,
      'task_id': tskID
    });

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print("Project Task---> : " + response.body);
    if (response.statusCode == 200) {
      print("Project Task---> : " + response.body);
      Map json = jsonDecode(response.body);
      var msg = json['msg'];
      /*Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(msg.toString()),
        backgroundColor: AppConfig.snackBarIFColor,
      ));*/
    } else {
      /*Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Profile Not Updated !!'),
          backgroundColor: AppConfig.snackBarELSEColor));*/
    }
  }
}
