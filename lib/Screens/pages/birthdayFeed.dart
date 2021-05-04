import 'dart:convert';

import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:AYT_Attendence/model/BirthdayModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class birthdayFeed extends StatefulWidget {
  @override
  birthdayFeedState createState() => birthdayFeedState();
}

class birthdayFeedState extends State<birthdayFeed> {
  Future<Birthdaymodel> newsdetail() async {
    var endpointUrl = All_API().baseurl + All_API().api_birthday;
    Map<String, String> queryParameter = {
      '': '',
    };
    String queryString = Uri(queryParameters: queryParameter).query;
    var requestUrl = endpointUrl + '?' + queryString;
    print(requestUrl);
    try {
      var response = await http.get(requestUrl, headers: {
        All_API().key: All_API().keyvalue,
      });
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print("Birthday : " + jsonString);
        var jsonMap = json.decode(jsonString);
        return Birthdaymodel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return Exception;
    }
  }

  @override
  Widget build(BuildContext context) {
    /*return Column(
      children: [
        Expanded(
          flex: 0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Happy Birthday',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[1000]),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 8,
          child: FutureBuilder<Birthdaymodel>(
            future: newsdetail(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var path = All_API().baseurl_img + snapshot.data.path;
                return ListView.builder(
                    itemCount: snapshot.data.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var article = snapshot.data.data[index];
                      print("birthdayimg-->" + path + article.image);
                      print("birthdayname-->" + article.name);
                      return Container(
                          width: screenSize.width * 0.5,
                          child:Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 120.0,
                                    height: 100.0,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              path + article.image),

                                        )
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(article.name,
                                    textScaleFactor: 1.1,
                                    style: TextStyle(fontSize:14,fontWeight:FontWeight.bold,color: Colors.orange)),
                                Text(article.designation,
                                    textScaleFactor: 0.9,style: TextStyle(fontSize:13,color: Colors.blue[1000]))
                              ],
                            ),

                          )


                      );
                    });
              } else if (snapshot.hasData == false) {
                return Container(
                         width: screenSize.width * 0.5,
                        child:Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 2,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(AppConfig.birthImageDefault,
                                  height: 150,width: 150,
                                fit: BoxFit.fill,),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(AppConfig.appUserNameDefault,
                                  textScaleFactor: 1.1,
                              style: TextStyle(fontSize:14,fontWeight:FontWeight.bold,color: Colors.orange)),
                              Text(AppConfig.appUserDepartmentDefault,
                                  textScaleFactor: 0.9,style: TextStyle(fontSize:13,color: Colors.blue[1000])),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),

                        )


                    );
              } else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );*/
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Happy Birthday',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppConfig.fontColor),
        ),
        SizedBox(
          height: 20,
        ),
        FutureBuilder<Birthdaymodel>(
          future: newsdetail(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var path = All_API().baseurl_img + snapshot.data.path;
              return Container(
                height: 250,
                child: ListView.builder(
                    itemCount: snapshot.data.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var article = snapshot.data.data[index];
                      print("birthdayimg-->" + path + article.image);
                      print("birthdayname-->" + article.name);
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  path + article.image,
                                  height: 150,
                                  width: 150,
                                ),
                              ),
                            ),
                            Text(article.name,
                                textScaleFactor: 1.1,
                                style: TextStyle(fontSize:14,fontWeight:FontWeight.bold,color: Colors.orange)),
                            Text(article.designation,
                                textScaleFactor: 0.9,style: TextStyle(fontSize:13,color: Colors.blue[1000])),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    }),
              );
            } else if (snapshot.hasData == false) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          AppConfig.birthImageDefault,
                          height: 150,
                          width: 150,
                        ),
                      ),
                    ),
                    Text(AppConfig.appUserNameDefault,
                        textScaleFactor: 1.1,
                        style: TextStyle(fontSize:14,fontWeight:FontWeight.bold,color: Colors.orange)),
                    Text(AppConfig.appUserDepartmentDefault,
                        textScaleFactor: 0.9,style: TextStyle(fontSize:13,color: Colors.blue[1000])),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}
