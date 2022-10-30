import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import './routes.dart';

final ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.lightBlue[800],
    fontFamily: 'Montserrat',
    colorScheme: ColorScheme.dark());

void _oneShotTaskCallback() {
  print("One Shot Task Running");
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  runApp(MyApp());
  await AndroidAlarmManager.oneShot(
      Duration(minutes: 1), 1, _oneShotTaskCallback);
}

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
