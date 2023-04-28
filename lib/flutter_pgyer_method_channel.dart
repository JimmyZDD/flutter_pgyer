/*
 * @Author: zdd
 * @Date: 2023-04-28 15:15:45
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-28 17:34:47
 * @FilePath: /grizzly_app/packages/flutter_pgyer/lib/flutter_pgyer_method_channel.dart
 * @Description: 
 */
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_pgyer_platform_interface.dart';

const kPgyerSetApiMethod = "flutter_pgyer/sdk/setApiKey";
const kPgyerCheckUpdateMethod = "flutter_pgyer/sdk/checkUpdate";
const kPgyerReportExceptionMethod = "flutter_pgyer/sdk/reportException";

/// An implementation of [FlutterPgyerPlatform] that uses method channels.
class MethodChannelFlutterPgyer extends FlutterPgyerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_pgyer');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> startManager(String appKey) async {
    if (Platform.isAndroid) return;
    try {
      await methodChannel
          .invokeMethod<String>(kPgyerSetApiMethod, {'appKey': appKey});
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> checkUpdate() async {
    try {
      await methodChannel.invokeMethod<String>(kPgyerCheckUpdateMethod);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> reportException(String name,
      {String? reason, Map? userInfo}) async {
    try {
      await methodChannel.invokeMethod<String>(kPgyerReportExceptionMethod, {
        'name': name,
        'reason': reason,
        'userInfo': userInfo,
      });
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }
}
