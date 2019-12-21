import 'package:flutter/services.dart';

class AudioManager {
  static const platform = const MethodChannel('alarm.flutter.dev/audio');
  
  static bool _alarmMuted;
  static int _audioLevel;
  static bool _isAlarmMax;

  static Future<void> _isAlarmMuted() async {
    try {
      _alarmMuted = await platform.invokeMethod('isAlarmMuted');
    } on PlatformException catch (e) {
      print("Failed to check if Alarm is Muted: '${e.message}'.");
    }
  }

  static Future<void> _getAudioAlarmVolume() async {
    try {
      _audioLevel = await platform.invokeMethod('getAudioAlarmVolume');
    } on PlatformException catch (e) {
      print("Failed to get Audio level: '${e.message}'.");
    }
  }

  static Future<void> _isAlarmVolumeMax() async {
    try {
      _isAlarmMax = await platform.invokeMethod('isAlarmMaxVolume');
    } on PlatformException catch (e) {
      print("Failed to get if Alarm Vol is Max: '${e.message}'.");
    }
  }

  /*
  *   public Methods
  */
  static Future<bool> isAlarmMuted() async {
    await _isAlarmMuted();
    return _alarmMuted;
  }

  static Future<bool> isAlarmVolumeMax() async {
    await _isAlarmVolumeMax();
    return _isAlarmMax;
  }

  static Future<int> getAudioAlarmVolume() async {
    await _getAudioAlarmVolume();
    return _audioLevel;
  }
}