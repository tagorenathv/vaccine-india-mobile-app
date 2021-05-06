import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_india/screens/alert_screen.dart';
import 'package:vaccine_india/screens/district_screen.dart';
import 'package:vaccine_india/screens/pincode_screen.dart';
import 'package:vaccine_india/widgets/main_appbar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  final screen = [DistrictScreen(), PincodeScrenn(), AlertScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MainAppBar(
          title: Text(
        "Vaccine India",
        style: TextStyle(
            fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
      )),
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.fastLinearToSlowEaseIn,
        animationDuration: Duration(milliseconds: 500),
        color: Colors.blue,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.blue,
        items: [
          Icon(
            Icons.home_rounded,
            size: 30,
            color: selectedIndex == 0 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.pin_drop_rounded,
            size: 30,
            color: selectedIndex == 1 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.notifications_rounded,
            size: 30,
            color: selectedIndex == 2 ? Colors.white : Colors.black,
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: screen[selectedIndex],
    );
  }
}
