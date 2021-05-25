import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_india/configs/color_constants.dart';
import 'package:vaccine_india/configs/padding_constants.dart';
import 'package:vaccine_india/screens/dashboard_screen.dart';
import 'package:vaccine_india/screens/info_screen.dart';
import 'package:vaccine_india/screens/notification_screen.dart';
import 'package:vaccine_india/screens/search_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    SearchScreen(),
    NotifyScreen(),
    InfoScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.kbackground,
        appBar: getAppBar(),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorConstants.kbackground,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: ColorConstants.kbottomNavBarSelectedColor,
          unselectedItemColor: ColorConstants.kbottomNavBarUnSelectedColor,
          items: getBottomNavigationBarItems(),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorConstants.kbackground,
      title: Center(
        child: Text(
          "Vaccine India",
          style: GoogleFonts.montserrat(
            color: ColorConstants.kmainColor,
            fontWeight: FontWeight.bold,
            textStyle: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> getBottomNavigationBarItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Container(
          padding: EdgeInsets.symmetric(
            vertical: PaddingConstants.knavBarVertical,
            horizontal: PaddingConstants.knavBarHorizontal,
          ),
          decoration: BoxDecoration(
            color: _selectedIndex == 0
                ? ColorConstants.kmainColor
                : Colors.transparent,
            borderRadius:
                BorderRadius.circular(PaddingConstants.knavBarCircularRadius),
          ),
          child: Icon(Icons.insert_chart),
        ),
        label: 'Dashboard',
      ),
      BottomNavigationBarItem(
        icon: Container(
          padding: EdgeInsets.symmetric(
            vertical: PaddingConstants.knavBarVertical,
            horizontal: PaddingConstants.knavBarHorizontal,
          ),
          decoration: BoxDecoration(
            color: _selectedIndex == 1
                ? ColorConstants.kmainColor
                : Colors.transparent,
            borderRadius:
                BorderRadius.circular(PaddingConstants.knavBarCircularRadius),
          ),
          child: Icon(Icons.search),
        ),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Container(
          padding: EdgeInsets.symmetric(
            vertical: PaddingConstants.knavBarVertical,
            horizontal: PaddingConstants.knavBarHorizontal,
          ),
          decoration: BoxDecoration(
            color: _selectedIndex == 2
                ? ColorConstants.kmainColor
                : Colors.transparent,
            borderRadius:
                BorderRadius.circular(PaddingConstants.knavBarCircularRadius),
          ),
          child: Icon(Icons.notifications),
        ),
        label: 'Notify',
      ),
      BottomNavigationBarItem(
        icon: Container(
          padding: EdgeInsets.symmetric(
            vertical: PaddingConstants.knavBarVertical,
            horizontal: PaddingConstants.knavBarHorizontal,
          ),
          decoration: BoxDecoration(
            color: _selectedIndex == 3
                ? ColorConstants.kmainColor
                : Colors.transparent,
            borderRadius:
                BorderRadius.circular(PaddingConstants.knavBarCircularRadius),
          ),
          child: Icon(Icons.info),
        ),
        label: 'Info',
      ),
    ];
  }
}
