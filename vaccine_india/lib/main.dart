import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_india/models/StateDistrictModel.dart';
import 'package:vaccine_india/models/StateModel.dart';
import 'package:vaccine_india/screens/main_screen.dart';
import 'models/globals/global_variables.dart' as Globals;
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  Globals.states = StateModel.getStates();
  Globals.stateDistricts = StateDistrictModel.getStateDistricts();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vaccine India',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: MainScreen(),
    );
  }
}
