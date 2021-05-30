import 'package:vaccine_india/models/DistrictModel.dart';
import 'package:vaccine_india/models/StateModel.dart';

List<StateModel> states = [];
Map<String, List<DistrictModel>> stateDistricts = {};
StateModel? selectedState;
DistrictModel? selectedDistrict;
String? ageCategory = "Above 45";
String? dosageCategory = "Dose-1";
String? pincode;
String? name;
String? email;
bool districtTab = true;
