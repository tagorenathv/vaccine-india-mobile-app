import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_india/helpers/districts_api.dart';
import 'package:vaccine_india/helpers/slots_api.dart';
import 'package:vaccine_india/models/CenterModel.dart';
import 'package:vaccine_india/models/DistrictModel.dart';
import 'package:vaccine_india/models/SlotModel.dart';
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  buildStateDropdown(),
                  buildDistrictDropdown(),
                  Divider(
                    color: Colors.white,
                  ),
                  slotsWidget(),
                ],
              ),
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

  Widget slotsWidget() {
    return FutureBuilder(
      future: SlotsApi.fetchSlotsByDistrict(selectedDistrict),
      initialData: ListView(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null) {
          return ListView();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              CenterModel centerModel = snapshot.data[index];
              return buildSlotdetailsOnCard(context, centerModel);
            },
          );
        }
        return CircularProgressIndicator();
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
      ),
    );
  }

  // Widget getSlotData(CenterModel centerModel) {
  //   return buildSlotdetailsOnCard(context, centerModel);
  //   // return widgets;
  //   // <Widget>[
  //   //   buildSlotdetailsOnCard(context),
  //   //   buildSlotdetailsOnCard(context),
  //   //   buildSlotdetailsOnCard(context),
  //   // ];
  // }

  Container buildSlotdetailsOnCard(
      BuildContext context, CenterModel centerModel) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 8.0),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    centerModel.centerName,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    centerModel.address1,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                  Text(
                    centerModel.address2,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Text(
                          centerModel.timeSchedule,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.shopping_cart_rounded,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Text(
                          centerModel.price,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  buildTable(context, centerModel.slots),
                ],
              ),
            ),
            Column(
              children: [
                Card(
                  elevation: 0,
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: Colors.blue,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.near_me_rounded),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: Colors.blue,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.read_more_rounded),
                      color: Colors.white,
                      onPressed: () => _showBottomSheet(context),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Table buildTable(BuildContext context, List<SlotModel> slots) {
    if (slots == null || slots.length == 0) {
      return Table();
    }
    SlotModel slot = slots[0];
    return Table(
      children: [
        TableRow(
          children: [
            Text(
              "Date",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              slot.date,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  ),
            ),
          ],
        ),
        TableRow(
          children: [
            Text(
              "Minimum Age",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  ),
            ),
            Text(
              slot.minAge,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        TableRow(
          children: [
            Text(
              "Vaccine Type",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              slot.vaccineType,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        TableRow(
          children: [
            Text(
              "Slots",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              slot.slotTimes,
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontFamily: 'Lato',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.4,
                minChildSize: 0.2,
                maxChildSize: 0.75,
                builder: (_, controller) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.remove,
                          color: Colors.grey[600],
                        ),
                        Expanded(
                          child: ListView.builder(
                            controller: controller,
                            itemCount: 100,
                            itemBuilder: (_, index) {
                              return Card(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text("Element at index($index)"),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
