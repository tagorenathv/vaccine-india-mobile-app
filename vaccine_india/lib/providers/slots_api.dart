import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:http/http.dart' as http;
import 'package:vaccine_india/models/CenterModel.dart';
import 'package:vaccine_india/models/DistrictModel.dart';

class SlotsApi {
  static Future<List<CenterModel>> fetchSlotsByDistrict(
      DistrictModel districtModel) async {
    if (districtModel == null) return [];

    final dateString = formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy]);
    String url =
        "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict?district_id=" +
            districtModel.districtId +
            "&date=" +
            dateString;

    String userAgent =
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36';

    print("calling slotsapi");
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
        List<dynamic> body = jsonDecode(response.body)['centers'];
        List<CenterModel> centers = body
            .map(
              (dynamic item) => CenterModel.fromJson(item),
            )
            .toList();
        print(centers);
        return centers;
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
