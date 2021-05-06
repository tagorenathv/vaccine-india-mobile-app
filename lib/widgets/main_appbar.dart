import 'package:flutter/material.dart';
import 'package:vaccine_india/widgets/waveclip.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  final Text title;
  final double barHeight = 50.0;

  MainAppBar({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        child: ClipPath(
          clipper: WaveClip(),
          child: Container(
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                title,
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 80.0);
}
