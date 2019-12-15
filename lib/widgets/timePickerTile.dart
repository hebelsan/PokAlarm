import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../datastructures/alarmItem.dart';

class TimePickerTile extends StatefulWidget {
  final AlarmItem alarmItem;

  TimePickerTile(this.alarmItem);

  @override
  _TimPickerState createState() => _TimPickerState();
}

class _TimPickerState extends State<TimePickerTile> {
  int _currValueHour = 0;
  int _currValueMin = 0;
  Decoration _decoration = new BoxDecoration(
    border: new Border(
      top: new BorderSide(
        style: BorderStyle.solid,
        color: Colors.white12,
      ),
      bottom: new BorderSide(
        style: BorderStyle.solid,
        color: Colors.white12,
      ),
    ),
  );

  void _handleChangeHour(num) {
    this.widget.alarmItem.setHours(num);
    setState(() => _currValueHour = num);
  }

  void _handleChangeMin(num) {
    this.widget.alarmItem.setMinutes(num);
    setState(() => _currValueMin = num);
  }

  @override
  Widget build(BuildContext context) {
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          NumberPicker.integer(
            initialValue: _currValueHour,
            minValue: 0,
            maxValue: 23,
            infiniteLoop: true,
            highlightSelectedValue: true,
            decoration: _decoration,
            onChanged: _handleChangeHour
            ),
          Text(':'),
          NumberPicker.integer(
            initialValue: _currValueMin,
            minValue: 0,
            maxValue: 59,
            infiniteLoop: true,
            highlightSelectedValue: true,
            decoration: _decoration,
            onChanged: _handleChangeMin
            ),
        ],
      );
  }
}