import 'package:flutter/material.dart';
import 'package:vaccine_india/models/SlotModel.dart';

Table buildTable(BuildContext context, SlotModel slot) {
  return Table(
    children: [
      TableRow(
        children: [
          Text(
            "Date",
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Colors.black54,
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
                  color: Colors.black54,
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
                  color: Colors.black54,
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
                  color: Colors.black54,
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
