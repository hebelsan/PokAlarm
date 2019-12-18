package com.example.timer

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.media.AudioManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES

class MainActivity: FlutterActivity() {
  private val CHANNEL = "alarm.flutter.dev/audio"

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
      when(call.method) {
        "getBatteryLevel" -> {
            val batteryLevel = getBatteryLevel()
            if (batteryLevel != -1) {
              result.success(batteryLevel)
            } else {
              result.error("UNAVAILABLE", "Battery level not available.", null)
            }
        }
        "getAudioAlarmVolume" -> {
            val audioLevel = getAudioAlarmVolume()
            if (audioLevel != -1) {
            result.success(audioLevel)
            } else {
            result.error("UNAVAILABLE", "Audio level not available.", null)
            }
        }
        "isAlarmMuted" -> {
            val isMuted = isAlarmMuted()
            //if (audioLevel != -1) {
            result.success(isMuted)
            //} else {
            //  result.error("UNAVAILABLE", "Audio level not available.", null)
            //}
        }
        "isAlarmMaxVolume" -> {
            val isAlarmMaxVol = isAlarmMaxVolume()
            //if (audioLevel != -1) {
            result.success(isAlarmMaxVol)
            //} else {
            //  result.error("UNAVAILABLE", "Audio level not available.", null)
            //}
        }
        else -> {
            result.notImplemented();
        }
      }  
    }
  }

  private fun getBatteryLevel(): Int {
    val batteryLevel: Int
    if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
      val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
      batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    } else {
      val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
      batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
    }
    return batteryLevel
  }

  private fun getAudioAlarmVolume(): Int {
    val audioLevel: Int
    if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
      val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
      audioLevel = audioManager.getStreamVolume(AudioManager.STREAM_ALARM)
    } else {
      // TODO Code for lower versions of android
      audioLevel = -1
    }
    return audioLevel
  }

  private fun isAlarmMuted(): Boolean {
    val isMuted: Boolean
    if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
      val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
      isMuted = audioManager.isStreamMute(AudioManager.STREAM_ALARM);
    } else {
      // TODO Code for lower versions of android
      isMuted = false
    }
    return isMuted
  }

  private fun isAlarmMaxVolume(): Boolean {
    val isAlarmMax: Boolean
    if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
      val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
      val maxVol: Int = audioManager.getStreamMaxVolume(AudioManager.STREAM_ALARM)
      val vol: Int = this.getAudioAlarmVolume()
      if (vol < maxVol) {
        isAlarmMax = false
      } else {
        isAlarmMax = true
      }
    } else {
      // TODO Code for lower versions of android
      isAlarmMax = true
    }
    return isAlarmMax
  }
}
