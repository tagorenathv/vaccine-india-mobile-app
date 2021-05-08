import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String titleText;
  final Color fontColor;

  const Header({Key key, this.titleText, this.fontColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        titleText,
        style: Theme.of(context).textTheme.headline5.copyWith(
              fontWeight: FontWeight.bold,
              color: fontColor,
            ),
      ),
    );
  }
}
