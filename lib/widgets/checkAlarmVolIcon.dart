import 'package:flutter/material.dart';
import './../datastructures/audioManager.dart';

class CheckAlarmVolIcon extends StatelessWidget {
  final Future<bool> _isAlarmMaxVolume = AudioManager.isAlarmVolumeMax();
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isAlarmMaxVolume, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          // Means alarm volume is set to max
          if (snapshot.data == true) {
            children = <Widget>[
              Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Alarm Max?: ${snapshot.data}'),
              )
            ];
          } else {
            children = <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Alarm Max?: ${snapshot.data}'),
              )
            ];
          }
        } else if (snapshot.hasError) {
          children = <Widget>[
            Icon(
              Icons.repeat,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          children = <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            )
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }
}