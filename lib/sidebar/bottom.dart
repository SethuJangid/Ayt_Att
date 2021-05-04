import 'package:AYT_Attendence/Screens/Expenses/track_expenses.dart';
import 'package:AYT_Attendence/Screens/leavelists/track_leave.dart';
import 'package:AYT_Attendence/Screens/pages/homepage.dart';
import 'package:AYT_Attendence/Screens/pages/myaccountspage.dart';
import 'package:AYT_Attendence/Widgets/AppConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';



class BottomNavBar extends StatefulWidget {


  BottomNavBar({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BottomNavBar> {
  PageController _pageController;
  MenuPositionController _menuPositionController;
  bool userPageDragging = false;
  String uniq_id;
  List<Widget> classes;

  @override
  void initState() {
    _menuPositionController = MenuPositionController(initPosition: 0);

    _pageController = PageController(
        initialPage: 0,
        keepPage: false,
        viewportFraction: 1.0
    );
    _pageController.addListener(handlePageChange);

    super.initState();
    getData();
  }

  getData()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      uniq_id = sharedPreferences.getString("unique_id");

      classes =[
        HomePage(),
        MyTrackExpenses(),
        MyTrackLeave(unique_id: uniq_id,),
        ProfileScreen(),
      ];

    });
  }

  final titles = ['Dashboard', 'Expenses', 'Track Leave', 'Profile',];
  final colors = [AppConfig.appBarTextColor, AppConfig.appBarTextColor, AppConfig.appBarTextColor, AppConfig.appBarTextColor, ];
  final icons = [
    Icons.home,
    Icons.explicit,
    Icons.article,
    Icons.person,
    Icons.notifications
  ];

  void handlePageChange() {
    _menuPositionController.absolutePosition = _pageController.page;
  }

  void checkUserDragging(ScrollNotification scrollNotification) {
    if (scrollNotification is UserScrollNotification && scrollNotification.direction != ScrollDirection.idle) {
      userPageDragging = true;
    } else if (scrollNotification is ScrollEndNotification) {
      userPageDragging = false;
    }
    if (userPageDragging) {
      _menuPositionController.findNearestTarget(_pageController.page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[1000],
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            checkUserDragging(scrollNotification);
          },
          child: PageView(
            controller: _pageController,
            ///children: widget.colors.map((Color c) => Container(color: c)).toList(),
            children: classes.map((Widget widget) => Container(child: widget,)).toList(),
            onPageChanged: (page) {
            },
          ),
        ),
        bottomNavigationBar: BubbledNavigationBar(
          controller: _menuPositionController,
          initialIndex: 0,
          itemMargin: EdgeInsets.symmetric(horizontal: 8),
          backgroundColor: AppConfig.appColorMain,
          defaultBubbleColor: Colors.blue,
          onTap: (index) {
            _pageController.animateToPage(
                index,
                curve: Curves.easeInOutQuad,
                duration: Duration(milliseconds: 50)
            );
          },
          items: titles.map((title) {
            var index = titles.indexOf(title);
            var color = colors[index];
            return BubbledNavigationBarItem(
              icon: getIcon(index, color),
              activeIcon: getIcon(index, AppConfig.appBarTextColor),
              bubbleColor: color,
              title: Text(
                title,
                style: TextStyle(color: AppConfig.textColor, fontSize: 12),
              ),
            );
          }).toList(),
        )
    );
  }

  Padding getIcon(int index, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Icon(icons[index], size: 30, color: color),
    );
  }
}
