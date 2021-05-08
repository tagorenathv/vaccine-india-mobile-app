import 'package:flutter/material.dart';
import 'package:vaccine_india/widgets/slots_by_pincode_widget.dart';

class PincodeScrenn extends StatefulWidget {
  @override
  _PincodeScrennState createState() => _PincodeScrennState();
}

class _PincodeScrennState extends State<PincodeScrenn> {
  TextEditingController _textController = TextEditingController();
  bool validate = false;
  String pincode = "";

  @override
  void initState() {
    pincode = "";
    validate = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Column(
              children: [
                buildPincodeSearchBoxWithButton(context),
                slotsWidgetByPincode(pincode),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding buildPincodeSearchBoxWithButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                autofocus: false,
                controller: _textController,
                decoration: InputDecoration(
                  errorText:
                      (pincode != null && pincode.isNotEmpty && !validate)
                          ? 'Enter valid Pincode'
                          : null,
                  hintText: 'Pincode',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _textController.clear();
                      setState(() {
                        pincode = "";
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(16)),
            child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  bool tempValid = false;
                  if (_textController.text.isNotEmpty &&
                      _textController.text.length > 3 &&
                      _isNumeric(_textController.text)) {
                    tempValid = true;
                  }
                  print(tempValid);
                  setState(() {
                    validate = tempValid;
                    pincode = _textController.text;
                  });

                  FocusScope.of(context).requestFocus(FocusNode());
                }),
          ),
        ],
      ),
    );
  }
}

bool _isNumeric(String result) {
  if (result == null) {
    return false;
  }
  return int.tryParse(result) != null;
}
