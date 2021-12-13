import 'package:flutter/material.dart';

import 'screens/homeScreen.dart';
import 'screens/setTimeScreen.dart';

var myRoutes = {
  // HomeScreen
  '/': (context) => HomeScreen(title: 'PokAlarm'),
  // SetTimeScreen
  '/setTime': (context) => SetTimeScreen(title: 'Choose Time'),
};

Function generatedRoutes = (settings) {
  final arguments = settings.arguments;
  switch (settings.name) {
    case '/':
      return HomeScreen(title: 'PokAlarm');
    case '/setTime':
      return SetTimeScreen(title: 'Choose Time', alarmItem: arguments);
    default:
      return null;
  }
};

Widget makeRoute(
    {@required BuildContext context,
    @required String routeName,
    Object arguments}) {
  final Widget child =
      _buildRoute(context: context, routeName: routeName, arguments: arguments);
  return child;
}

Widget _buildRoute({
  @required BuildContext context,
  @required String routeName,
  Object arguments,
}) {
  switch (routeName) {
    case '/':
      return HomeScreen(title: 'PokAlarm');
    case '/setTime':
      return SetTimeScreen(title: 'Choose Time', alarmItem: arguments);
    default:
      return null;
  }
}
