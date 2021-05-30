import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_india/models/StatsModel.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  StatsModel statsModel = StatsModel("N/A", "N/A", "N/A", "N/A", "N/A", "N/A",
      "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "");
  Future<void> fetchData() async {
    FirebaseFirestore.instance
        .collection("stats")
        .doc("today")
        .snapshots()
        .listen((event) {
      setState(() {
        // userPhotos = event.get("photoUrl");
        statsModel = StatsModel(
          event.get("total"),
          event.get("active"),
          event.get("discharged"),
          event.get("deaths"),
          event.get("total_vaccination"),
          event.get("total_change"),
          event.get("active_change"),
          event.get("discharged_change"),
          event.get("deaths_change"),
          event.get("total_vaccination_change"),
          event.get("active_percentage"),
          event.get("discharged_percentage"),
          event.get("deaths_percentage"),
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Statistics',
                style: const TextStyle(
                  color: Color(0xff0C2AAF),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: Column(
                      children: [
                        _buildStatCardRow('Total Cases', statsModel.total,
                            '100', statsModel.totalChange, Colors.purple),
                        _buildStatCardRow(
                            'Active Cases',
                            statsModel.active,
                            statsModel.activePercentage,
                            statsModel.activeChange,
                            Colors.lightBlue),
                        _buildStatCardRow(
                            'Discharged',
                            statsModel.discharged,
                            statsModel.dischargePercentage,
                            statsModel.dischargedChange,
                            Colors.lightGreen),
                        _buildStatCardRow(
                            'Deaths',
                            statsModel.deaths,
                            statsModel.deathsPercentage,
                            statsModel.deathsChange,
                            Colors.red),
                        _buildStatCardRow(
                            'Total Vaccination',
                            statsModel.totalVaccinated,
                            '',
                            statsModel.totalVaccinatedChange,
                            Colors.teal),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildStatCardRow(String title, String count, String percentage,
      String change, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (percentage.isNotEmpty)
                  Text(
                    '$percentage%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  count,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: change,
                      ),
                      WidgetSpan(
                        child: Icon(
                          Icons.arrow_upward_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
