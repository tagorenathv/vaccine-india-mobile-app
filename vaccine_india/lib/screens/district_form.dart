import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_india/models/DistrictModel.dart';
import 'package:vaccine_india/models/StateModel.dart';

class DistrictForm extends StatefulWidget {
  @override
  _DistrictFormState createState() => _DistrictFormState();
}

class _DistrictFormState extends State<DistrictForm> {
  StateModel? selectedState;
  DistrictModel? selectedDistrict;
  List<StateModel> stateModelList = [];

  @override
  void initState() {
    super.initState();
    stateModelList = StateModel.getStates();
    selectedState = stateModelList.first;
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
              ],
            ),
          ),
        ],
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
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(16),
          // ),
          hintText: "Search State",
        ),
        autoFocusSearchBox: true,
        showSearchBox: true,
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
          });

          print(selectedState);
        },
        filterFn: (state, filter) => state.filterByStateName(filter),
        compareFn: (i, s) => i.isEqual(s!),
        label: "State",
        hint: "Search State",
        showClearButton: false,
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
