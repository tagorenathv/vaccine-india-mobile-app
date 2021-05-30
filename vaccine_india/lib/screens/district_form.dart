import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_india/configs/color_constants.dart';
import 'package:vaccine_india/models/DistrictModel.dart';
import 'package:vaccine_india/models/StateModel.dart';
import 'package:vaccine_india/models/globals/global_variables.dart' as Globals;

class DistrictForm extends StatefulWidget {
  @override
  _DistrictFormState createState() => _DistrictFormState();
}

class _DistrictFormState extends State<DistrictForm> {
  // StateModel? selectedState;
  // DistrictModel? selectedDistrict;
  List<StateModel> stateModelList = Globals.states;
  Map<String, List<DistrictModel>> stateDistricts = Globals.stateDistricts;
  int _ageRadioValue = 1;
  int _doseRadioValue = 0;

  @override
  void initState() {
    super.initState();
    Globals.districtTab = true;
    Globals.selectedState = StateModel('', '');
    Globals.selectedDistrict = DistrictModel(districtId: '', districtName: '');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildStateDropdown(),
                buildDistrictDropdown(),
                // buildAgeRadioButtonGroup(),
                // buildDoseRadioButtonGroup(),
                buildButton(
                  onTap: () {},
                  text: 'Search',
                  color: ColorConstants.kmainColor,
                ),
                Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyDistrictDropDown(BuildContext context, String searchEntry) {
    String message = "";
    if (Globals.selectedState == null ||
        Globals.selectedState!.stateId.isEmpty) {
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

  Padding buildDistrictDropdown() {
    return Padding(
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
        maxHeight: MediaQuery.of(context).size.height * 0.6,
        autoFocusSearchBox: false,
        showSearchBox: false,
        mode: Mode.BOTTOM_SHEET,
        showSelectedItem: true,
        items: stateDistricts[Globals.selectedState!.stateId],
        itemAsString: (DistrictModel s) => s.districtName,
        selectedItem: Globals.selectedDistrict,
        emptyBuilder: (context, searchEntry) =>
            _emptyDistrictDropDown(context, searchEntry!),
        onChanged: (DistrictModel? data) {
          setState(() {
            Globals.selectedDistrict = data;
          });
        },
        // filterFn: (state, filter) => state.filterByStateName(filter),
        compareFn: (i, s) => i.isEqual(s!),
        label: "District",
        hint: "Search District",
        showClearButton: false,
        popupSafeArea: PopupSafeArea(top: true, bottom: true),
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (DistrictModel? value) {
          if (value!.districtId.isEmpty || value.districtName.isEmpty) {
            return "Select a District";
          }
        },
      ),
    );
  }

  Padding buildStateDropdown() {
    return Padding(
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
        maxHeight: MediaQuery.of(context).size.height * 0.6,
        autoFocusSearchBox: false,
        showSearchBox: false,
        mode: Mode.BOTTOM_SHEET,
        showSelectedItem: true,
        items: stateModelList,
        itemAsString: (StateModel s) => s.stateName,
        selectedItem: Globals.selectedState,
        emptyBuilder: (context, searchEntry) =>
            _emptyStateDropDown(context, searchEntry!),
        onChanged: (StateModel? data) {
          setState(() {
            Globals.selectedState = data;
            Globals.selectedDistrict =
                DistrictModel(districtId: '', districtName: '');
          });

          print(Globals.selectedState);
        },
        // filterFn: (state, filter) => state.filterByStateName(filter),
        compareFn: (i, s) => i.isEqual(s!),
        label: "State",
        hint: "Search State",
        showClearButton: false,
        popupSafeArea: PopupSafeArea(top: true, bottom: true),
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (StateModel? value) {
          if (value!.stateId.isEmpty || value.stateName.isEmpty) {
            return "Select a State";
          }
        },
      ),
    );
  }

  Widget _emptyStateDropDown(BuildContext context, String searchEntry) {
    String message = "";
    if (Globals.selectedState == null) {
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

  Padding buildAgeRadioButtonGroup() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new Text(
                'Age',
                style: GoogleFonts.montserratTextTheme().headline1!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new Radio(
                value: 0,
                groupValue: _ageRadioValue,
                onChanged: (int? data) {
                  setState(() {
                    _ageRadioValue = data!;
                  });
                },
              ),
              new Text(
                '18-45',
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),
              new Radio(
                value: 1,
                groupValue: _ageRadioValue,
                onChanged: (int? data) {
                  setState(() {
                    _ageRadioValue = data!;
                  });
                },
              ),
              new Text(
                'Above 45',
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding buildDoseRadioButtonGroup() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new Text(
                'Dose',
                style: GoogleFonts.montserratTextTheme().headline1!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new Radio(
                value: 0,
                groupValue: _doseRadioValue,
                onChanged: (int? data) {
                  setState(() {
                    _doseRadioValue = data!;
                  });
                },
              ),
              new Text(
                'Dose 1',
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),
              new Radio(
                value: 1,
                groupValue: _doseRadioValue,
                onChanged: (int? data) {
                  setState(() {
                    _doseRadioValue = data!;
                  });
                },
              ),
              new Text(
                'Dose 2',
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ],
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
}
