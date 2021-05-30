class NotifyModel {
  final String stateId;
  final String districtId;
  final String pincode;
  final String ageCategory;
  final String name;
  final String email;

  NotifyModel(this.stateId, this.districtId, this.pincode, this.ageCategory,
      this.name, this.email);

  @override
  String toString() {
    return this.stateId +
        " | " +
        this.districtId +
        " | " +
        this.pincode +
        " | " +
        ageCategory +
        " | " +
        name +
        " | " +
        email;
  }
}
