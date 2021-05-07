import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_india/helpers/pincode_api.dart';
import 'package:vaccine_india/models/CenterModel.dart';
import 'package:vaccine_india/models/SlotModel.dart';

class PincodeScrenn extends StatefulWidget {
  @override
  _PincodeScrennState createState() => _PincodeScrennState();
}

class _PincodeScrennState extends State<PincodeScrenn> {
  TextEditingController _textController = TextEditingController();
  String pincode;

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
            child: Column(
              children: [
                buildPincodeSearchBoxWithButton(context),
                slotsWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget slotsWidget() {
    return FutureBuilder(
      future: PincodeApi.fetchSlotsByPincode(pincode),
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
            itemCount: getSnapshotDataLength(snapshot),
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

  getSnapshotDataLength(AsyncSnapshot snapshot) {
    try {
      return snapshot.data.length;
    } on Exception catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
    return 0;
  }

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
                  (centerModel.slots == null || centerModel.slots.length == 0)
                      ? Table()
                      : buildTable(context, centerModel.slots[0]),
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
                      onPressed: () => _showBottomSheet(context, centerModel),
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

  Table buildTable(BuildContext context, SlotModel slot) {
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
                autofocus: true,
                controller: _textController,
                decoration: InputDecoration(
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
                color: Colors.blue, borderRadius: BorderRadius.circular(16)),
            child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    pincode = _textController.text;
                  });
                  FocusScope.of(context).requestFocus(FocusNode());
                }),
          ),
        ],
      ),
    );
  }

  ListView getListView(BuildContext context, CenterModel centerModel) {
    return ListView(
      shrinkWrap: true,
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Railway Dispe',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Brand',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      "\$ 12:30",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.near_me_rounded,
                      ),
                      iconSize: 28,
                      tooltip: 'Navigate to Center',
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.expand_more_rounded,
                      ),
                      iconSize: 32,
                      onPressed: () => _showBottomSheet(context, centerModel),
                      tooltip: 'More Slot Details',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Railway Dispe',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Brand',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      "\$ 12:30",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.near_me_rounded,
                      ),
                      iconSize: 28,
                      tooltip: 'Navigate to Center',
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.expand_more_rounded,
                      ),
                      iconSize: 32,
                      onPressed: () {},
                      tooltip: 'More Slot Details',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Railway Dispe',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Brand',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      "\$ 12:30",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.near_me_rounded,
                      ),
                      iconSize: 28,
                      tooltip: 'Navigate to Center',
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.expand_more_rounded,
                      ),
                      iconSize: 32,
                      onPressed: () {},
                      tooltip: 'More Slot Details',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Railway Dispe',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Brand',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      "\$ 12:30",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.near_me_rounded,
                      ),
                      iconSize: 28,
                      tooltip: 'Navigate to Center',
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.expand_more_rounded,
                      ),
                      iconSize: 32,
                      onPressed: () => _showBottomSheet(context, centerModel),
                      tooltip: 'More Slot Details',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context, CenterModel centerModel) {
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            centerModel.centerName,
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            controller: controller,
                            itemCount: (centerModel.slots == null)
                                ? 0
                                : centerModel.slots.length,
                            itemBuilder: (_, index) {
                              return Card(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: buildTable(
                                      context, centerModel.slots[index]),
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
