class DistrictModel {
  final String districtId;
  final String districtName;

  DistrictModel({required this.districtId, required this.districtName});

  bool isEqual(DistrictModel model) {
    return this.districtId == model.districtId;
  }

  bool filterByDistrictName(String filter) {
    print("filter string at disna: " + filter);
    return this.districtName.contains(filter.toUpperCase());
  }

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
        districtId: json['district_id'].toString(),
        districtName: json['district_name'].toString().toUpperCase());
  }
}
