import 'package:flutter/material.dart';
import 'package:vaccine_india/configs/color_constants.dart';
import 'package:vaccine_india/screens/district_form.dart';
import 'package:vaccine_india/screens/pincode_form.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: ColorConstants.kbackground,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TabBar(
                indicatorColor: ColorConstants.kmainColor,
                tabs: [
                  new Tab(
                    text: "District",
                  ),
                  new Tab(
                    text: "Pincode",
                  ),
                ],
                unselectedLabelColor: Colors.black,
                labelColor: ColorConstants.kmainColor,
              ),
              Expanded(
                child: TabBarView(children: <Widget>[
                  DistrictForm(),
                  PincodeForm(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
