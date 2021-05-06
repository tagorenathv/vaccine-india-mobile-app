class StateDistrictModel {
  final String stateName;
  final String stateId;
  final String districtName;
  final String districtId;

  StateDistrictModel(
      this.stateName, this.stateId, this.districtName, this.districtId);

  String userAsString() {
    return '#${this.stateId} ${this.stateName}';
  }

  bool isEqual(StateDistrictModel model) {
    return this.stateId == model?.stateId;
  }
}
