class StatsModel {
  final String total;
  final String active;
  final String discharged;
  final String deaths;
  final String totalVaccinated;
  final String totalChange;
  final String activeChange;
  final String dischargedChange;
  final String deathsChange;
  final String totalVaccinatedChange;
  final String activePercentage;
  final String dischargePercentage;
  final String deathsPercentage;

  StatsModel(
      this.total,
      this.active,
      this.discharged,
      this.deaths,
      this.totalVaccinated,
      this.totalChange,
      this.activeChange,
      this.dischargedChange,
      this.deathsChange,
      this.totalVaccinatedChange,
      this.activePercentage,
      this.dischargePercentage,
      this.deathsPercentage);
}
