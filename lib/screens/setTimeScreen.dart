import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class SetTimeScreen extends StatelessWidget {
  final String title;

  SetTimeScreen({this.title});

  int _currValueHour = 0;
  int _currValueMin = 0;

  void _handleChangeHour(num) {
    _currValueHour = num;
  }

  void _handleChangeMin(num) {
    _currValueMin = num;
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
            Row(
              children: <Widget>[
                NumberPicker.integer(
                  initialValue: _currValueHour,
                  minValue: 0,
                  maxValue: 23,
                  onChanged: _handleChangeHour),
                Text(':'),
                NumberPicker.integer(
                  initialValue: _currValueMin,
                  minValue: 0,
                  maxValue: 59,
                  onChanged: _handleChangeMin),
              ],
            ),
              
            RaisedButton(
              onPressed: () {Navigator.pop(context);},
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