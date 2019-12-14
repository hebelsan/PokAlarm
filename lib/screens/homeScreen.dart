import 'package:flutter/material.dart';

import './../widgets/alarmBarTile.dart';
import './../datastructures/alarmItem.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _numAlarms = 0;
  List<AlarmBarTile> alarmTiles = [];

  void _addAlarm() {
    Navigator.pushNamed(context, '/setTime');
    AlarmItem ai = AlarmItem("Timer is set on 7:00", false);
    alarmTiles.add(AlarmBarTile(ai));
    setState(() {
      _numAlarms++;
    });
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
