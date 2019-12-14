import 'screens/homeScreen.dart';
import 'screens/setTimeScreen.dart';

var myRoutes = {
  // HomeScreen
  '/': (context) => HomeScreen(title: 'PokAlarm'),
  // SetTimeScreen
  '/setTime': (context) => SetTimeScreen(title: 'Choose Time'),
};