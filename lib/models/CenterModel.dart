import 'package:flutter/material.dart';

import 'SlotModel.dart';

class CenterModel {
  final String centerName;
  final String address1;
  final String address2;
  final String timeSchedule;
  final String price;
  final int lat;
  final int lon;
  final List<SlotModel> slots;

  CenterModel(
      {@required this.centerName,
      @required this.address1,
      @required this.address2,
      @required this.timeSchedule,
      @required this.price,
      @required this.lat,
      @required this.lon,
      @required this.slots});

  factory CenterModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> sessions = json["sessions"];
    List<SlotModel> slots = [];
    sessions.forEach((element) {
      List<dynamic> sessionSlots = element["slots"];
      String slottime =
          sessionSlots.reduce((value, element) => value + ', ' + element);
      slots.add(
        SlotModel(
          element["date"],
          element["min_age_limit"].toString(),
          element["vaccine"],
          slottime,
        ),
      );
    });

    return CenterModel(
        centerName: json["name"],
        address1: json["block_name"] + json["address"],
        address2: json["district_name"] + json["state_name"],
        timeSchedule: json["from"] + " to " + json["to"],
        price: json["fee_type"],
        lat: json["lat"],
        lon: json["long"],
        slots: slots);
  }
}
