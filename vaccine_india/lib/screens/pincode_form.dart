import 'package:flutter/material.dart';
import 'package:vaccine_india/configs/color_constants.dart';
import 'package:vaccine_india/utils/numeric_validator_util.dart';

class PincodeForm extends StatefulWidget {
  @override
  _PincodeFormState createState() => _PincodeFormState();
}

class _PincodeFormState extends State<PincodeForm> {
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
          Column(
            children: [
              buildPincodeSearchBoxWithButton(context),
              // slotsWidgetByPincode(pincode),
            ],
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
                  errorText: (pincode.isNotEmpty && !validate)
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
              color: ColorConstants.kmainColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  bool tempValid = false;
                  if (_textController.text.isNotEmpty &&
                      _textController.text.length > 3 &&
                      NumericValidatorUtil.isNumeric(_textController.text)) {
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
