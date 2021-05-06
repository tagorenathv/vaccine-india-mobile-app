import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

class PincodeScrenn extends StatefulWidget {
  @override
  _PincodeScrennState createState() => _PincodeScrennState();
}

class _PincodeScrennState extends State<PincodeScrenn> {
  TextEditingController _textController = TextEditingController();

  final border = OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(5)));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Pincode',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _textController.clear();
                  },
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  CoolAlert.show(
                      context: context,
                      type: CoolAlertType.loading,
                      autoCloseDuration: Duration(seconds: 2));
                }),
          )
        ],
      ),
    );
  }
}
