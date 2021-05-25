import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class TestClass extends StatefulWidget {
  @override
  _TestClassState createState() => _TestClassState();
}

class _TestClassState extends State<TestClass> {
  DatePickerController _controller = DatePickerController();
  LinkedScrollControllerGroup _controllers;
  ScrollController _letters;
  ScrollController _numbers;
  ScrollController _cont;
  DateTime _selectedValue = DateTime.now();
  @override
  void initState() {
    _controllers = LinkedScrollControllerGroup();
    _letters = _controllers.addAndGet();
    _numbers = _controllers.addAndGet();
    _cont = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _letters.dispose();
    _numbers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return SingleChildScrollView(
    //   child: Container(
    //     padding: EdgeInsets.all(20.0),
    //     color: Colors.blueGrey[100],
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: <Widget>[
    //         Container(
    //           child: DatePicker(
    //             DateTime.now(),
    //             controller: _controller,
    //             initialSelectedDate: DateTime.now(),
    //             selectionColor: Colors.black,
    //             selectedTextColor: Colors.white,
    //             daysCount: 14,
    //             onDateChange: (date) {
    //               // New date selected
    //               setState(() {
    //                 _selectedValue = date;
    //               });
    //             },
    //           ),
    //         ),
    //         Container(
    //             margin: EdgeInsets.symmetric(vertical: 20.0),
    //             height: 200.0,
    //             child: new ListView(
    //               scrollDirection: Axis.horizontal,
    //               children: <Widget>[
    //                 Container(
    //                   width: 160.0,
    //                   color: Colors.red,
    //                 ),
    //                 Container(
    //                   width: 160.0,
    //                   color: Colors.orange,
    //                 ),
    //                 Container(
    //                   width: 160.0,
    //                   color: Colors.pink,
    //                 ),
    //                 Container(
    //                   width: 160.0,
    //                   color: Colors.yellow,
    //                 ),
    //               ],
    //             ))
    //       ],
    //     ),
    //   ),
    // );
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              controller: _cont,
              children: <Widget>[
                _Tile('Hello A'),
                _Tile('Hello B'),
                _Tile('Hello C'),
                _Tile('Hello D'),
                _Tile('Hello E'),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              controller: _cont,
              children: <Widget>[
                _Tile('Hello 1'),
                _Tile('Hello 2'),
                _Tile('Hello 3'),
                _Tile('Hello 4'),
                _Tile('Hello 5'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final String caption;

  _Tile(this.caption);

  @override
  Widget build(_) => Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        height: 250.0,
        child: Center(child: Text(caption)),
      );
}
