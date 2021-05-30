import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vaccine_india/configs/color_constants.dart';
import 'package:vaccine_india/models/DistrictModel.dart';
import 'package:vaccine_india/models/NotifyModel.dart';
import 'package:vaccine_india/models/StateModel.dart';
import 'package:vaccine_india/models/globals/global_variables.dart' as Globals;

class NotifyScreen extends StatefulWidget {
  @override
  _NotifyScreenState createState() => _NotifyScreenState();
}

class _NotifyScreenState extends State<NotifyScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();

  StateModel? selectedState;
  DistrictModel? selectedDistrict;
  String selectedAgeCategory = "18-45";
  String selectedDoseCategory = "Dose-1";
  String radioAge = '18-45';
  int radioIdAge = 1;
  String? name;
  String? email;
  List<StateModel> stateModelList = Globals.states;
  Map<String, List<DistrictModel>> stateDistricts = Globals.stateDistricts;

  @override
  void initState() {
    super.initState();
    selectedState = StateModel('', '');
    selectedDistrict = DistrictModel(districtId: '', districtName: '');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter valid Name';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            setState(() {
                              name = newValue;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            hintText: 'Enter your Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            if (isNotValidEmail(value!)) {
                              return 'Enter valid Email';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            setState(() {
                              email = newValue;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownSearch<StateModel>(
                          dropdownSearchDecoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          searchBoxDecoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: "Search State",
                          ),
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (StateModel? value) {
                            if (value!.stateId.isEmpty ||
                                value.stateName.isEmpty) {
                              return "Select a State";
                            }
                          },
                          maxHeight: MediaQuery.of(context).size.height * 0.6,
                          autoFocusSearchBox: false,
                          showSearchBox: false,
                          mode: Mode.BOTTOM_SHEET,
                          showSelectedItem: true,
                          items: stateModelList,
                          itemAsString: (StateModel s) => s.stateName,
                          selectedItem: selectedState,
                          emptyBuilder: (context, searchEntry) =>
                              _emptyStateDropDown(context, searchEntry!),
                          onChanged: (StateModel? data) {
                            setState(() {
                              selectedState = data;
                              selectedDistrict = DistrictModel(
                                  districtId: '', districtName: '');
                            });

                            print(selectedState);
                          },
                          // filterFn: (state, filter) => state.filterByStateName(filter),
                          compareFn: (i, s) => i.isEqual(s!),
                          label: "State",
                          hint: "Search State",
                          showClearButton: false,
                          popupSafeArea: PopupSafeArea(top: true, bottom: true),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownSearch<DistrictModel>(
                          dropdownSearchDecoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          searchBoxDecoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: "Search District",
                          ),
                          validator: (DistrictModel? value) {
                            if (value!.districtId.isEmpty ||
                                value.districtName.isEmpty) {
                              return "Select a District";
                            }
                          },
                          maxHeight: MediaQuery.of(context).size.height * 0.6,
                          autoFocusSearchBox: false,
                          showSearchBox: false,
                          mode: Mode.BOTTOM_SHEET,
                          showSelectedItem: true,
                          items: stateDistricts[selectedState!.stateId],
                          itemAsString: (DistrictModel s) => s.districtName,
                          selectedItem: selectedDistrict,
                          emptyBuilder: (context, searchEntry) =>
                              _emptyDistrictDropDown(context, searchEntry!),
                          onChanged: (DistrictModel? data) {
                            setState(() {
                              selectedDistrict = data;
                            });
                          },
                          // filterFn: (state, filter) => state.filterByStateName(filter),
                          compareFn: (i, s) => i.isEqual(s!),
                          label: "District",
                          hint: "Search District",
                          showClearButton: false,
                          popupSafeArea: PopupSafeArea(top: true, bottom: true),
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownSearch<String>(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Select Age Category';
                            }
                            return null;
                          },
                          dropdownSearchDecoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          searchBoxDecoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          autoFocusSearchBox: true,
                          showSearchBox: false,
                          mode: Mode.BOTTOM_SHEET,
                          showSelectedItem: true,
                          items: ["18-45", "Above 45"],
                          selectedItem: selectedAgeCategory,
                          onChanged: (String? data) {
                            setState(() {
                              selectedAgeCategory = data!;
                            });
                          },
                          label: "Age",
                          showClearButton: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownSearch<String>(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Select Dose Category';
                            }
                            return null;
                          },
                          dropdownSearchDecoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          searchBoxDecoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          autoFocusSearchBox: true,
                          showSearchBox: false,
                          mode: Mode.BOTTOM_SHEET,
                          showSelectedItem: true,
                          items: ["Dose-1", "Dose-2"],
                          selectedItem: selectedDoseCategory,
                          onChanged: (String? data) {
                            setState(() {
                              selectedDoseCategory = data!;
                            });
                          },
                          label: "Dose",
                          showClearButton: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _create(NotifyModel(
                                  selectedState!.stateId,
                                  selectedDistrict!.districtId,
                                  "", //pincode
                                  selectedAgeCategory,
                                  name!,
                                  email!));
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                text:
                                    'You Will be Notified on Slot Availability!\n\n Stay Safe.',
                                backgroundColor: Colors.white,
                              );
                            }
                          },
                          text: 'Notify',
                          color: ColorConstants.kmainColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _emptyDistrictDropDown(BuildContext context, String searchEntry) {
    String message = "";
    if (selectedState == null || selectedState!.stateId.isEmpty) {
      message = "Select a State";
    } else {
      message = "No District Found at the moment";
    }
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
      ),
    );
  }

  Widget _emptyStateDropDown(BuildContext context, String searchEntry) {
    String message = "";
    if (selectedState == null) {
      message = "Search for Valid State";
    } else {
      message = "No State Found at the moment";
    }
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
      ),
    );
  }

  bool isNotValidEmail(String value) {
    return !RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
  }

  Widget _buildButton(
      {VoidCallback? onTap, required String? text, Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
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
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  void _create(NotifyModel notifyModel) async {
    try {
      print(notifyModel.toString());
      await firestore.collection('users').doc(Uuid().v4()).set({
        'stateId': notifyModel.stateId,
        'districtId': notifyModel.districtId,
        'ageCategory': notifyModel.ageCategory,
        'name': notifyModel.name,
        'email': notifyModel.email,
        'notified': false
      });
    } catch (e) {
      print(e);
    }
  }
}
