import 'package:flutter/material.dart';

class PincodeForm extends StatefulWidget {
  @override
  _PincodeFormState createState() => _PincodeFormState();
}

class _PincodeFormState extends State<PincodeForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[],
      ),
    );
  }
}
