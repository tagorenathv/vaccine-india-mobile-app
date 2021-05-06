import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vaccine_india/helpers/districts_api.dart';
import 'package:vaccine_india/models/DistrictModel.dart';
import 'package:vaccine_india/models/NotifyModel.dart';
import 'package:vaccine_india/models/StateModel.dart';

class AlertScreen extends StatefulWidget {
  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();

  StateModel selectedState;
  DistrictModel selectedDistrict;
  String selectedAgeCategory;
  String name;
  String email;
  List<StateModel> stateModelList = [];
  List<DistrictModel> districtModelList = [];

  @override
  void initState() {
    stateModelList = StateModel.getStates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
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
                    child: DropdownSearch<StateModel>(
                      validator: (StateModel value) {
                        if (value == null) {
                          return 'Select State';
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
                      showSearchBox: true,
                      mode: Mode.MENU,
                      showSelectedItem: true,
                      items: stateModelList,
                      itemAsString: (StateModel s) => s.stateName,
                      selectedItem: selectedState,
                      onChanged: (StateModel data) {
                        setState(() {
                          if (data == null) {
                            selectedState = null;
                          } else {
                            selectedState = data;
                          }
                        });
                      },
                      filterFn: (state, filter) =>
                          state.filterByStateName(filter),
                      compareFn: (i, s) => i.isEqual(s),
                      label: "State",
                      hint: "Search State",
                      showClearButton: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      future: DistrictApi.fetchDistrictsByState(selectedState),
                      initialData: [],
                      builder: (context, snapshot) {
                        return districtSearchableDropdown(context, snapshot);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownSearch<String>(
                      validator: (String value) {
                        if (value == null || value.isEmpty) {
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
                      mode: Mode.MENU,
                      showSelectedItem: true,
                      items: ["18-45", "Above 45"],
                      selectedItem: selectedAgeCategory,
                      onChanged: (String data) {
                        setState(() {
                          if (data == null || data.isEmpty) {
                            selectedAgeCategory = null;
                          } else {
                            selectedAgeCategory = data;
                          }
                        });
                      },
                      label: "Age",
                      showClearButton: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
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
                      validator: (String value) {
                        if (value.isEmpty || isNotValidEmail(value)) {
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
                    child: _buildButton(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          _create(NotifyModel(
                              selectedState.stateId,
                              selectedDistrict.districtId,
                              selectedAgeCategory,
                              name,
                              email));
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.success,
                            text: 'You Will be Notified on Slot Availability!',
                          );
                        }
                      },
                      text: 'Notify',
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isNotValidEmail(String value) {
    return !RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
  }

  Widget districtSearchableDropdown(
      BuildContext context, AsyncSnapshot snapshot) {
    List<DistrictModel> values = List<DistrictModel>.from(snapshot.data);

    return DropdownSearch<DistrictModel>(
      validator: (DistrictModel value) {
        if (value == null) {
          return 'Select District';
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
      showSearchBox: true,
      mode: Mode.MENU,
      showSelectedItem: true,
      items: values,
      itemAsString: (DistrictModel s) => s.districtName,
      selectedItem: selectedDistrict,
      onChanged: (DistrictModel data) {
        setState(() {
          if (data == null) {
            selectedDistrict = null;
          } else {
            selectedDistrict = data;
          }
          print(selectedDistrict);
        });
      },
      filterFn: (state, filter) => state.filterByDistrictName(filter),
      compareFn: (i, s) => i.isEqual(s),
      label: "District",
      hint: "Search District",
      showClearButton: true,
    );
  }

  Widget _buildButton(
      {VoidCallback onTap, @required String text, Color color}) {
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
            text,
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
