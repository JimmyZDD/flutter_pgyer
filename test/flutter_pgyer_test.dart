/*
 * @Author: zdd
 * @Date: 2023-04-28 15:15:45
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-28 16:40:58
 * @FilePath: /grizzly_app/packages/flutter_pgyer/test/flutter_pgyer_test.dart
 * @Description: 
 */
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pgyer/flutter_pgyer.dart';
import 'package:flutter_pgyer/flutter_pgyer_platform_interface.dart';
import 'package:flutter_pgyer/flutter_pgyer_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockFlutterPgyerPlatform
//     with MockPlatformInterfaceMixin
//     implements FlutterPgyerPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

void main() {
  final FlutterPgyerPlatform initialPlatform = FlutterPgyerPlatform.instance;

  test('$MethodChannelFlutterPgyer is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPgyer>());
  });

  test('getPlatformVersion', () async {
    FlutterPgyer flutterPgyerPlugin = FlutterPgyer();
    // MockFlutterPgyerPlatform fakePlatform = MockFlutterPgyerPlatform();
    // FlutterPgyerPlatform.instance = fakePlatform;

    // expect(await flutterPgyerPlugin.getPlatformVersion(), '42');
  });
}
