import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_india/helpers/districts_api.dart';
import 'package:vaccine_india/models/DistrictModel.dart';
import 'package:vaccine_india/models/StateModel.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          DropdownSearch<StateModel>(
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
                  selectedDistrict = null;
                } else {
                  selectedState = data;
                }
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
          Divider(),
          FutureBuilder(
            future: DistrictApi.fetchDistrictsByState(selectedState),
            initialData: [],
            builder: (context, snapshot) {
              return districtSearchableDropdown(context, snapshot);
            },
          ),
        ],
      ),
    );
  }

  Widget districtSearchableDropdown(
      BuildContext context, AsyncSnapshot snapshot) {
    List<DistrictModel> values = List<DistrictModel>.from(snapshot.data);
    return DropdownSearch<DistrictModel>(
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
}
