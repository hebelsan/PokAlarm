import 'package:flutter/material.dart';

import './alarmItem.dart';

class AlarmTile extends StatefulWidget {
  final AlarmItem alarmItem;

  AlarmTile(this.alarmItem);

  @override
  _AlarmTileState createState() => new _AlarmTileState();
}

class _AlarmTileState extends State<AlarmTile> {
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