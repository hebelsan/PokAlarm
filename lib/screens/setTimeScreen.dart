import 'package:flutter/material.dart';

import './../widgets/timePickerTile.dart';
import './../datastructures/alarmItem.dart';

class SetTimeScreen extends StatelessWidget {
  final String title;
  final AlarmItem alarmItem;

  SetTimeScreen({this.title, this.alarmItem});

  void _onSetTime(context) {
    alarmItem.createTimeObject(DateTime.now());
    Navigator.pop(context);
    alarmItem.addTimerCallback(alarmItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TimePickerTile(alarmItem),
            RaisedButton(
              onPressed: () => _onSetTime(context),
              child: Text(
                'Set Time',
                style: TextStyle(fontSize: 20)
              ),
            ),
          ],
        ),
      ),
    );
  }
}