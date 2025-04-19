package com.example.screen_lock_check;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import android.content.Context;
import android.annotation.TargetApi;
import android.os.Build; 
import android.content.ContentResolver; 
import android.provider.Settings;
import android.app.KeyguardManager;

/** ScreenLockCheckPlugin */
public class ScreenLockCheckPlugin implements FlutterPlugin, MethodCallHandler {
  private MethodChannel channel;
  private static Context context = null;


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "screen_lock_check");
    context = flutterPluginBinding.getApplicationContext();
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("isScreenLockEnabled")) {
      result.success(isDeviceScreenLocked(context));
    } else {
      result.notImplemented();
    }
  }
  private static boolean isDeviceScreenLocked(Context appCon) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
      return isDeviceLocked(appCon);
    } else {
      return isPatternSet(appCon) || isPassOrPinSet(appCon);
    }
  }
  private static boolean isPatternSet(Context appCon) {

    ContentResolver cr = appCon.getContentResolver();
    try {
      int lockPatternEnable = Settings.Secure.getInt(cr, Settings.Secure.LOCK_PATTERN_ENABLED);
      return lockPatternEnable == 1;
    } catch (Settings.SettingNotFoundException e) {
      return false;
    }
  }
  private static boolean isPassOrPinSet(Context appCon) {
    KeyguardManager keyguardManager = (KeyguardManager) appCon.getSystemService(Context.KEYGUARD_SERVICE); //api 16+
    return keyguardManager.isKeyguardSecure();
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
  @TargetApi(23)
  private static boolean isDeviceLocked(Context appCon) {
    KeyguardManager keyguardManager = (KeyguardManager) appCon.getSystemService(Context.KEYGUARD_SERVICE); //api 23+
    return keyguardManager.isDeviceSecure();
  }
}
