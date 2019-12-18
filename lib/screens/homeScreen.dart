import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './../widgets/alarmBarTile.dart';
import './../datastructures/alarmItem.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  HomeScreen({Key key, this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platform = const MethodChannel('alarm.flutter.dev/audio');
  // Get battery level.
  String _alarmMuted = 'Unknown if Muted';
  String _audioLevel = 'Unknown audio Level';
  String _isAlarmMax = 'Unknown if alarmvol is max';

  Future<void> _isAlarmMuted() async {
    String isMuted;
    try {
      final bool result = await platform.invokeMethod('isAlarmMuted');
      isMuted = 'Alarm is Muted?: $result';
    } on PlatformException catch (e) {
      isMuted = "Failed to check if Alarm is Muted: '${e.message}'.";
    }

    setState(() {
      _alarmMuted = isMuted;
    });
  }

  Future<void> _getAudioAlarmVolume() async {
    String audioLevel;
    try {
      final int result = await platform.invokeMethod('getAudioAlarmVolume');
      audioLevel = 'AudioLevel: $result';
    } on PlatformException catch (e) {
      audioLevel = "Failed to get Audio level: '${e.message}'.";
    }

    setState(() {
      _audioLevel = audioLevel;
    });
  }

  Future<void> _isAlarmVolumeMax() async {
    String isAlarmMax;
    try {
      final bool result = await platform.invokeMethod('isAlarmMaxVolume');
      isAlarmMax = 'Is AlarmVol Max?: $result';
    } on PlatformException catch (e) {
      isAlarmMax = "Failed to get if Alarm Vol is Max: '${e.message}'.";
    }

    setState(() {
      _isAlarmMax = isAlarmMax;
    });
  }

  int _numAlarms = 0;
  List<AlarmBarTile> alarmTiles = [];

  void addTimerCallback(ai) {
    _getAudioAlarmVolume();
    _isAlarmMuted();
    _isAlarmVolumeMax();
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
            Text(
              _alarmMuted,
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              _audioLevel,
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              _isAlarmMax,
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
