import 'package:flutter/material.dart';

import './../datastructures/alarmItem.dart';

class AlarmBarTile extends StatefulWidget {
  final AlarmItem alarmItem;

  AlarmBarTile(this.alarmItem);

  @override
  _AlarmTileState createState() => new _AlarmTileState(alarmItem.isOn);
}

class _AlarmTileState extends State<AlarmBarTile> {
  bool _isSwitched;

  _AlarmTileState(this._isSwitched);

  void _onSwitch(value) {
    this.widget.alarmItem.setValue(value);
    setState(() {
      _isSwitched = value;
    });
  }

  String _buildTimeStringHelper() {
    return 
      this.widget.alarmItem.text +
      ' at: ' +
      this.widget.alarmItem.timeObject.hour.toString() +
      ':' + 
      this.widget.alarmItem.timeObject.minute.toString();
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
              child: Text(
                _buildTimeStringHelper(),
                textAlign:TextAlign.left),
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