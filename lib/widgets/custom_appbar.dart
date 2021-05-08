import 'package:flutter/material.dart';

import 'header_widget.dart';

class CustomAppBar extends AppBar {
  final double size;
  final Color color;
  final String titleText;

  CustomAppBar(this.size, this.color, this.titleText)
      : super(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: color,
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(),
            child: Header(
              titleText: titleText,
              fontColor: color,
            ),
          ),
        );
}
