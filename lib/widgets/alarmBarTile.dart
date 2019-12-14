import 'package:flutter/material.dart';

import './../datastructures/alarmItem.dart';

class AlarmBarTile extends StatefulWidget {
  final AlarmItem alarmItem;

  AlarmBarTile(this.alarmItem);

  @override
  _AlarmTileState createState() => new _AlarmTileState();
}

class _AlarmTileState extends State<AlarmBarTile> {
  bool _isSwitched = false;

  void _onSwitch(value) {
    this.widget.alarmItem.setValue(value);
    setState(() {
      _isSwitched = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
    Column(
      children: <Widget>[
        Divider(
          color: Colors.white,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(this.widget.alarmItem.text, textAlign:TextAlign.left),
            ),
            Expanded(
              child: Switch(
                value: _isSwitched,
                onChanged: _onSwitch,
                inactiveThumbColor: Theme.of(context).accentColor,
                activeTrackColor: Colors.lightGreenAccent, 
                activeColor: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }
}