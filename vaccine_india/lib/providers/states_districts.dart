import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class StateDistrictResourceLoader {
  Future<Map<String, dynamic>> loadAsset() async {
    print('assets/data/state_districts.json');
    var jsonString = await rootBundle.loadString("assets/state_districts.json");
    return jsonDecode(jsonString);
  }
}
