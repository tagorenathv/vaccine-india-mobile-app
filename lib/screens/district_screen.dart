import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_india/helpers/districts_api.dart';
import 'package:vaccine_india/models/DistrictModel.dart';
import 'package:vaccine_india/models/StateModel.dart';
import 'package:vaccine_india/widgets/slots_by_district_widget.dart';

class DistrictScreen extends StatefulWidget {
  @override
  _DistrictScreenState createState() => _DistrictScreenState();
}

class _DistrictScreenState extends State<DistrictScreen> {
  StateModel selectedState;
  DistrictModel selectedDistrict;
  List<StateModel> stateModelList = [];
  List<DistrictModel> districtModelList = [];

  @override
  void initState() {
    stateModelList = StateModel.getStates();
    districtModelList = [];
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
            child: Column(
              children: [
                buildStateDropdown(),
                buildDistrictDropdown(),
                Divider(
                  color: Colors.white,
                ),
                slotsWidget(selectedDistrict),
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
        emptyBuilder: _emptyStateDropDown,
        onChanged: (StateModel data) {
          setState(() {
            if (data == null) {
              selectedState = null;
            } else {
              selectedState = data;
            }
            selectedDistrict = null;
          });

          print(selectedState);
          print(selectedDistrict);
        },
        filterFn: (state, filter) => state.filterByStateName(filter),
        compareFn: (i, s) => i.isEqual(s),
        label: "State",
        hint: "Search State",
        showClearButton: true,
      ),
    );
  }

  FutureBuilder<List> buildDistrictDropdown() {
    return FutureBuilder(
      future: DistrictApi.fetchDistrictsByState(selectedState),
      initialData: [],
      builder: (context, snapshot) {
        return districtSearchableDropdown(context, snapshot);
      },
    );
  }

  Widget districtSearchableDropdown(
      BuildContext context, AsyncSnapshot snapshot) {
    List<DistrictModel> values = List<DistrictModel>.from(snapshot.data);
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
          hintText: 'Search District',
        ),
        emptyBuilder: _emptyDistrictDropDown,
        autoFocusSearchBox: true,
        showSearchBox: true,
        mode: Mode.BOTTOM_SHEET,
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
      ),
    );
  }

  Widget _emptyDistrictDropDown(BuildContext context, String searchEntry) {
    String message = "";
    if (selectedState == null) {
      message = "Select a State";
    } else {
      message = "No District Found at the moment";
    }
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.headline6.copyWith(
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
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
      ),
    );
  }
}
