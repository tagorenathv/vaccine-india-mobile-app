class NotifyModel {
  final String stateId;
  final String districtId;
  final String ageCategory;
  final String name;
  final String email;

  NotifyModel(
      this.stateId, this.districtId, this.ageCategory, this.name, this.email);

  @override
  String toString() {
    return this.stateId +
        " | " +
        this.districtId +
        " | " +
        ageCategory +
        " | " +
        name +
        " | " +
        email;
  }
}
