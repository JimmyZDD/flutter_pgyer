/*
 * @Author: zdd
 * @Date: 2023-04-28 15:15:45
 * @LastEditors: zdd
 * @LastEditTime: 2023-05-05 14:03:45
 * @FilePath: /flutter_pgyer/android/src/main/java/com/grizzlychina/flutter_pgyer/FlutterPgyerPlugin.java
 * @Description: 
 */
package com.grizzlychina.flutter_pgyer;


import androidx.annotation.NonNull;
import android.app.Activity;
import android.util.Log;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import com.pgyer.pgyersdk.PgyerSDKManager;

/** FlutterPgyerPlugin */
public class FlutterPgyerPlugin implements FlutterPlugin, ActivityAware, MethodCallHandler {
  private static final String TAG = FlutterPgyerPlugin.class.getSimpleName();

  private static final String kPgyerCheckUpdateMethod = "flutter_pgyer/sdk/checkUpdate";
  private static final String kPgyerReportExceptionMethod = "flutter_pgyer/sdk/reportException";
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Activity mActivity;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_pgyer");
    channel.setMethodCallHandler(this);

    // 初始化蒲公英SDK
    new PgyerSDKManager.Init().setContext(flutterPluginBinding.getApplicationContext()).start();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals(kPgyerCheckUpdateMethod)) {
      Log.d(TAG, "CheckUpdate");
      PgyerSDKManager.checkSoftwareUpdate();
    } else if (call.method.equals(kPgyerReportExceptionMethod)) {
      if (call.hasArgument("name")){
        String name = call.argument("name");
        Exception e = new Exception(name);
        PgyerSDKManager.reportException(e);
      }
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(ActivityPluginBinding activityPluginBinding) {
    mActivity = activityPluginBinding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {
    Log.d(TAG, "onDetachedFromActivity");
  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
    Log.d(TAG, "onReattachedToActivityForConfigChanges");
    onAttachedToActivity(binding);
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    Log.d(TAG, "onDetachedFromActivityForConfigChanges");
    onDetachedFromActivity();
  }
}
