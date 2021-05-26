import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_india/models/DistrictModel.dart';
import 'package:vaccine_india/models/StateModel.dart';
import 'package:vaccine_india/models/globals/global_variables.dart' as Globals;

class DistrictForm extends StatefulWidget {
  @override
  _DistrictFormState createState() => _DistrictFormState();
}

class _DistrictFormState extends State<DistrictForm> {
  StateModel? selectedState;
  DistrictModel? selectedDistrict;
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                buildStateDropdown(),
                buildDistrictDropdown(),
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
        selectedItem: selectedState,
        emptyBuilder: (context, searchEntry) =>
            _emptyStateDropDown(context, searchEntry!),
        onChanged: (StateModel? data) {
          setState(() {
            selectedState = data;
            selectedDistrict = DistrictModel(districtId: '', districtName: '');
          });

          print(selectedState);
        },
        // filterFn: (state, filter) => state.filterByStateName(filter),
        compareFn: (i, s) => i.isEqual(s!),
        label: "State",
        hint: "Search State",
        showClearButton: false,
        popupSafeArea: PopupSafeArea(top: true, bottom: true),
        autoValidateMode: AutovalidateMode.onUserInteraction,
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
}
