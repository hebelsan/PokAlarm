import 'package:flutter/material.dart';

import './../widgets/alarmBarTile.dart';
import './../widgets/checkAlarmVolIcon.dart';
import './../datastructures/alarmItem.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  HomeScreen({Key key, this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _numAlarms = 0;
  List<AlarmBarTile> alarmTiles = [];

  void addTimerCallback(ai) {
    alarmTiles.add(AlarmBarTile(ai));
    setState(() {
      _numAlarms++;
    });
  }

  void _addAlarm() {
    AlarmItem ai = AlarmItem(true, addTimerCallback);
    Navigator.pushNamed(context, '/setTime', arguments: ai);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for(var alarm in alarmTiles ) alarm,
            Text(
              '$_numAlarms',
              style: Theme.of(context).textTheme.display1,
            ),
            CheckAlarmVolIcon(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAlarm,
        tooltip: 'Add new alarm',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
