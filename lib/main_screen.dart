import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_india/screens/about_screen.dart';
import 'package:vaccine_india/screens/alert_screen.dart';
import 'package:vaccine_india/screens/district_screen.dart';
import 'package:vaccine_india/screens/pincode_screen.dart';
import 'package:vaccine_india/screens/time_test.dart';
import 'package:vaccine_india/widgets/main_appbar_widget.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  PageController _pageController;
  final screen = [
    DistrictScreen(),
    PincodeScrenn(),
    AlertScreen(),
    AboutScreen(),
    TestClass()
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      // appBar: MainAppBar(
      //   title: Text(
      //     "Vaccine India",
      //     style: TextStyle(
      //       fontSize: 35,
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        title: Center(
          child: Text(
            'Vaccine India',
            style: Theme.of(context).textTheme.headline4.copyWith(
                  color: Colors.white,
                  fontFamily: 'opensans',
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   height: 60,
      //   animationCurve: Curves.fastLinearToSlowEaseIn,
      //   animationDuration: Duration(milliseconds: 500),
      //   color: Colors.white,
      //   backgroundColor: Colors.blue,
      //   buttonBackgroundColor: Colors.white,
      //   items: [
      //     Icon(
      //       Icons.home_rounded,
      //       size: 30,
      //       color: selectedIndex == 0 ? Colors.blue : Colors.black,
      //     ),
      //     Icon(
      //       Icons.pin_drop_rounded,
      //       size: 30,
      //       color: selectedIndex == 1 ? Colors.blue : Colors.black,
      //     ),
      //     Icon(
      //       Icons.notifications_rounded,
      //       size: 30,
      //       color: selectedIndex == 2 ? Colors.blue : Colors.black,
      //     ),
      //     Icon(
      //       Icons.settings_rounded,
      //       size: 30,
      //       color: selectedIndex == 3 ? Colors.blue : Colors.black,
      //     ),
      //     Icon(
      //       Icons.access_alarm_rounded,
      //       size: 30,
      //       color: selectedIndex == 3 ? Colors.blue : Colors.black,
      //     ),
      //   ],
      //   onTap: (index) {
      //     setState(() {
      //       selectedIndex = index;
      //     });
      //   },
      // ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.blue,
        selectedIndex: selectedIndex,
        onItemSelected: (index) {
          setState(() => selectedIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            activeColor: Colors.white,
            inactiveColor: Colors.black,
            title: Text(
              'District',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            icon: selectedIndex == 0
                ? Icon(Icons.home_rounded)
                : Icon(
                    Icons.home_rounded,
                    color: Colors.black,
                  ),
          ),
          BottomNavyBarItem(
            activeColor: Colors.white,
            inactiveColor: Colors.black,
            title: Text(
              'Pincode',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            icon: selectedIndex == 1
                ? Icon(Icons.pin_drop_rounded)
                : Icon(
                    Icons.pin_drop_rounded,
                    color: Colors.black,
                  ),
          ),
          BottomNavyBarItem(
            activeColor: Colors.white,
            inactiveColor: Colors.black,
            title: Text(
              'Notify',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            icon: selectedIndex == 2
                ? Icon(Icons.notifications_rounded)
                : Icon(
                    Icons.notifications_rounded,
                    color: Colors.black,
                  ),
          ),
          BottomNavyBarItem(
            activeColor: Colors.white,
            inactiveColor: Colors.black,
            title: Text(
              'Blogs',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            icon: selectedIndex == 3
                ? Icon(Icons.settings_rounded)
                : Icon(
                    Icons.settings_rounded,
                    color: Colors.black,
                  ),
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: screen,
      ),
    );
  }
}
