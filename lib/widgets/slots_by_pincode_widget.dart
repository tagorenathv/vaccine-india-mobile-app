import 'package:flutter/material.dart';
import 'package:vaccine_india/helpers/pincode_api.dart';
import 'package:vaccine_india/models/CenterModel.dart';
import 'package:vaccine_india/widgets/slots_data_oncard_widget.dart';

Widget slotsWidgetByPincode(String pincode) {
  return FutureBuilder(
    future: PincodeApi.fetchSlotsByPincode(pincode),
    initialData: ListView(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.none &&
          snapshot.hasData == null) {
        return ListView();
      }

      if (pincode.isNotEmpty &&
          _isNumeric(pincode) &&
          snapshot.connectionState == ConnectionState.done &&
          getSnapshotDataLength(snapshot) < 1) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'No Available Slots for Pincode',
              style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        );
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

bool _isNumeric(String result) {
  if (result == null) {
    return false;
  }
  return int.tryParse(result) != null;
}
