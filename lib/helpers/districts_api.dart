import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:vaccine_india/models/DistrictModel.dart';
import 'package:vaccine_india/models/StateModel.dart';

class DistrictApi {
  static Future<List<DistrictModel>> fetchDistrictsByState(
      StateModel stateModel) async {
    if (stateModel == null) return [];

    String url = "https://cdn-api.co-vin.in/api/v2/admin/location/districts/" +
        stateModel.stateId;
    String userAgent =
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'accept': 'application/json',
        'Accept-Language': 'en_US',
        'User-Agent': userAgent,
      },
    );
    print(response);
    try {
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body)['districts'];
        List<DistrictModel> districts = body
            .map(
              (dynamic item) => DistrictModel.fromJson(item),
            )
            .toList();
        print(districts);
        return districts;
      } else {
        throw Exception('Failed to load districts');
      }
    } on Exception catch (exception) {
      print(exception);
    } catch (error) {
      print(error);
    }
    return [];
  }
}
