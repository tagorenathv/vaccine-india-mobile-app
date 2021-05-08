import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_india/models/CenterModel.dart';
import 'package:vaccine_india/widgets/slots_data_ontable_widget.dart';
import 'package:url_launcher/url_launcher.dart';

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
                      Icons.place_rounded,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        centerModel.pincode.toString(),
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
                    onPressed: () => _navigateTo(context,
                        centerModel.lat.toDouble(), centerModel.lon.toDouble()),
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

void _navigateTo(BuildContext context, double lat, double lng) async {
  print(lat.toString() + lng.toString());
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
  try {
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        autoCloseDuration: Duration(seconds: 3),
        text: "Device Not supported. Unable to open Maps.!",
      );
      print('Could not open the map.');
    }
  } on Exception catch (e) {
    print(e);
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      autoCloseDuration: Duration(seconds: 3),
      text: "Device Not supported. Unable to open Maps.!",
    );
  } catch (error) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      autoCloseDuration: Duration(seconds: 3),
      text: "Device Not supported. Unable to open Maps.!",
    );
  }
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
                          style: Theme.of(context).textTheme.headline6.copyWith(
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
