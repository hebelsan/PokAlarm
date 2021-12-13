import 'package:flutter/material.dart';

import './routes.dart';

final ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.lightBlue[800],
    fontFamily: 'Montserrat',
    colorScheme: ColorScheme.dark());

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokAlarm',
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => makeRoute(
            context: context,
            routeName: settings.name,
            arguments: settings.arguments,
          ),
          maintainState: true,
          fullscreenDialog: false,
        );
      },
      theme: theme,
    );
  }
}
