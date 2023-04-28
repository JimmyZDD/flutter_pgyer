/*
 * @Author: zdd
 * @Date: 2023-04-28 15:15:45
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-28 16:45:20
 * @FilePath: /grizzly_app/packages/flutter_pgyer/lib/flutter_pgyer.dart
 * @Description: 
 */
import 'flutter_pgyer_platform_interface.dart';

class FlutterPgyer {
  static Future<String?> getPlatformVersion() {
    return FlutterPgyerPlatform.instance.getPlatformVersion();
  }

  static startIOSManager(String appKey) {
    FlutterPgyerPlatform.instance.startManager(appKey);
  }

  static checkUpdate() {
    FlutterPgyerPlatform.instance.checkUpdate();
  }

  static reportException(String name, {String? reason, Map? userInfo}) {
    FlutterPgyerPlatform.instance
        .reportException(name, reason: reason, userInfo: userInfo);
  }
}
