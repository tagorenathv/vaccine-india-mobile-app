import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:vaccine_india/configs/color_constants.dart';
import 'package:vaccine_india/configs/padding_constants.dart';
import 'package:vaccine_india/models/NotifyModel.dart';
import 'package:vaccine_india/screens/blogs_screen.dart';
import 'package:vaccine_india/screens/dashboard_screen.dart';
import 'package:vaccine_india/screens/info_screen.dart';
import 'package:vaccine_india/screens/search_screen.dart';
import 'package:vaccine_india/models/globals/global_variables.dart' as Globals;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textController = TextEditingController();
  bool validate = false;
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    SearchScreen(),
    // NotifyScreen(),
    BlogScreen(),
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
        body: _widgetOptions.elementAt(_selectedIndex),
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
        floatingActionButton: _selectedIndex == 1
            ? FloatingActionButton(
                onPressed: () {
                  displayBottomSheet(context);
                },
                backgroundColor: ColorConstants.kmainColor,
                child: Icon(
                  Icons.notification_add,
                ),
              )
            : null,
      ),
    );
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            if (Globals.districtTab == true)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Enter valid Name';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    setState(() {
                                      Globals.name = newValue;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    hintText: 'Enter your Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            if (Globals.districtTab == true)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? value) {
                                    if (isNotValidEmail(value!)) {
                                      return 'Enter valid Email';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    setState(() {
                                      Globals.email = newValue;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    hintText: 'Enter Email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            if (!Globals.districtTab)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  autofocus: false,
                                  controller: _textController,
                                  decoration: InputDecoration(
                                    errorText: (Globals.pincode!.isNotEmpty &&
                                            !validate)
                                        ? 'Enter valid Pincode'
                                        : null,
                                    hintText: 'Pincode',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        _textController.clear();
                                        setState(() {
                                          Globals.pincode = "";
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownSearch<String>(
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Select Age Category';
                                  }
                                  return null;
                                },
                                dropdownSearchDecoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                searchBoxDecoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                autoFocusSearchBox: true,
                                showSearchBox: false,
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.3,
                                mode: Mode.BOTTOM_SHEET,
                                showSelectedItem: true,
                                items: ["18-45", "Above 45"],
                                selectedItem: Globals.ageCategory,
                                onChanged: (String? data) {
                                  setState(() {
                                    Globals.ageCategory = data!;
                                  });
                                },
                                label: "Age",
                                showClearButton: false,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownSearch<String>(
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Select Dose Category';
                                  }
                                  return null;
                                },
                                dropdownSearchDecoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                searchBoxDecoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                autoFocusSearchBox: true,
                                showSearchBox: false,
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.3,
                                mode: Mode.BOTTOM_SHEET,
                                showSelectedItem: true,
                                items: ["Dose-1", "Dose-2"],
                                selectedItem: Globals.dosageCategory,
                                onChanged: (String? data) {
                                  setState(() {
                                    Globals.dosageCategory = data!;
                                  });
                                },
                                label: "Dose",
                                showClearButton: false,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _buildButton(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    _create(NotifyModel(
                                        Globals.selectedState!.stateId,
                                        Globals.selectedDistrict!.districtId,
                                        Globals.pincode!,
                                        Globals.ageCategory!,
                                        Globals.name!,
                                        Globals.email!));
                                    Navigator.pop(context);
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.success,
                                      text:
                                          'You Will be Notified on Slot Availability!\n\n Stay Safe.',
                                      backgroundColor: Colors.white,
                                    );
                                  }
                                },
                                text: 'Notify',
                                color: ColorConstants.kmainColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton(
      {VoidCallback? onTap, required String? text, Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: MaterialButton(
        color: color,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            text!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  void _create(NotifyModel notifyModel) async {
    try {
      print(notifyModel.toString());
      await firestore.collection('users').doc(Uuid().v4()).set({
        'stateId': notifyModel.stateId,
        'districtId': notifyModel.districtId,
        'ageCategory': notifyModel.ageCategory,
        'name': notifyModel.name,
        'email': notifyModel.email,
        'notified': false
      });
    } catch (e) {
      print(e);
    }
  }

  bool isNotValidEmail(String value) {
    return !RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
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
          child: Icon(
            Icons.rss_feed,
          ),
        ),
        label: 'Blog',
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
