import 'package:flutter/material.dart';
import 'package:vaccine_india/configs/color_constants.dart';
import 'package:vaccine_india/models/globals/global_variables.dart' as Globals;

class PincodeForm extends StatefulWidget {
  @override
  _PincodeFormState createState() => _PincodeFormState();
}

class _PincodeFormState extends State<PincodeForm> {
  TextEditingController _textController = TextEditingController();
  bool validate = false;

  @override
  void initState() {
    Globals.pincode = "";
    Globals.districtTab = false;
    validate = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    controller: _textController,
                    decoration: InputDecoration(
                      errorText: (Globals.pincode!.isNotEmpty && !validate)
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
                            Globals.pincode = "";
                          });
                        },
                      ),
                    ),
                  ),
                ),
                buildButton(
                  onTap: () {},
                  text: 'Search',
                  color: ColorConstants.kmainColor,
                ),
                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(
      {VoidCallback? onTap, required String? text, Color? color}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
      child: MaterialButton(
        color: color,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            text!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Padding buildPincodeSearchBoxWithButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: TextInputType.number,
        autofocus: false,
        controller: _textController,
        decoration: InputDecoration(
          errorText: (Globals.pincode!.isNotEmpty && !validate)
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
                Globals.pincode = "";
              });
            },
          ),
        ),
      ),
    );
  }
}

// Container(
//   decoration: BoxDecoration(
//     color: ColorConstants.kmainColor,
//     borderRadius: BorderRadius.circular(16),
//   ),
//   child: IconButton(
//       icon: Icon(
//         Icons.search,
//         color: Colors.white,
//       ),
//       onPressed: () {
//         bool tempValid = false;
//         if (_textController.text.isNotEmpty &&
//             _textController.text.length > 3 &&
//             NumericValidatorUtil.isNumeric(_textController.text)) {
//           tempValid = true;
//         }
//         print(tempValid);
//         setState(() {
//           validate = tempValid;
//           Globals.pincode = _textController.text;
//         });

//         FocusScope.of(context).requestFocus(FocusNode());
//       }),
// ),
