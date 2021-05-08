import 'package:flutter/material.dart';
import 'package:vaccine_india/helpers/slots_api.dart';
import 'package:vaccine_india/models/CenterModel.dart';
import 'package:vaccine_india/models/DistrictModel.dart';
import 'package:vaccine_india/widgets/slots_data_oncard_widget.dart';

Widget slotsWidget(DistrictModel selectedDistrict) {
  return FutureBuilder(
    future: SlotsApi.fetchSlotsByDistrict(selectedDistrict),
    initialData: ListView(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.none &&
          snapshot.hasData == null) {
        return ListView();
      }

      if (selectedDistrict != null &&
          snapshot.connectionState == ConnectionState.done &&
          getSnapshotDataLength(snapshot) < 1) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'No Available Slots for District',
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
  }
  return 0;
}
