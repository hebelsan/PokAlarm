package com.example.timer

import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine


import java.util.concurrent.TimeUnit

import io.reactivex.Observable
import io.reactivex.disposables.Disposable
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

import androidx.annotation.NonNull
import android.util.Log
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

  private val STREAM_TAG = "alarm.eventchannel.sample/stream";

  private var timerSubscription : Disposable? = null

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine)

    Log.w("HELLO_TAG", "Start OnCreate...")

    // MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
    //   when(call.method) {
    //     "getBatteryLevel" -> {
    //         val batteryLevel = getBatteryLevel()
    //         if (batteryLevel != -1) {
    //           result.success(batteryLevel)
    //         } else {
    //           result.error("UNAVAILABLE", "Battery level not available.", null)
    //         }
    //     }
    //     "getAudioAlarmVolume" -> {
    //         val audioLevel = getAudioAlarmVolume()
    //         if (audioLevel != -1) {
    //         result.success(audioLevel)
    //         } else {
    //         result.error("UNAVAILABLE", "Audio level not available.", null)
    //         }
    //     }
    //     "isAlarmMuted" -> {
    //         val isMuted = isAlarmMuted()
    //         //if (audioLevel != -1) {
    //         result.success(isMuted)
    //         //} else {
    //         //  result.error("UNAVAILABLE", "Audio level not available.", null)
    //         //}
    //     }
    //     "isAlarmMaxVolume" -> {
    //         val isAlarmMaxVol = isAlarmMaxVolume()
    //         //if (audioLevel != -1) {
    //         result.success(isAlarmMaxVol)
    //         //} else {
    //         //  result.error("UNAVAILABLE", "Audio level not available.", null)
    //         //}
    //     }
    //     else -> {
    //         result.notImplemented();
    //     }
    //   }
    // }

    EventChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), STREAM_TAG).setStreamHandler(
      object : EventChannel.StreamHandler {
        override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
          Log.w("TAG", "adding listener")
          this@MainActivity.timerSubscription = Observable
             .interval(1000, TimeUnit.MILLISECONDS)
             .observeOn(AndroidSchedulers.mainThread())
             .subscribe (
               {  
                 Log.w("Test", "Result we just received: $it"); 
                 events.success(it);
               }, // OnSuccess
               { error -> events.error("STREAM", "Error in processing observable", error); }, // OnError
               { println("Complete"); } // OnCompletion
             )
        }
    
        override fun onCancel(arguments: Any?) {
          Log.w("TAG", "adding listener")
          if (this@MainActivity.timerSubscription != null) {
            this@MainActivity.timerSubscription?.dispose()
            this@MainActivity.timerSubscription = null
          }
        }
      }
    )

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
    if (VERSION.SDK_INT >= VERSION_CODES.O) {
      val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
      isMuted = audioManager.isStreamMute(AudioManager.STREAM_ALARM)
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
