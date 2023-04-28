import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_pgyer_method_channel.dart';

abstract class FlutterPgyerPlatform extends PlatformInterface {
  /// Constructs a FlutterPgyerPlatform.
  FlutterPgyerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPgyerPlatform _instance = MethodChannelFlutterPgyer();

  /// The default instance of [FlutterPgyerPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPgyer].
  static FlutterPgyerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPgyerPlatform] when
  /// they register themselves.
  static set instance(FlutterPgyerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> startManager(String appKey) {
    throw UnimplementedError(
        'startManager(String appKey) has not been implemented.');
  }

  Future<void> checkUpdate() {
    throw UnimplementedError('checkUpdate() has not been implemented.');
  }

  Future<void> reportException(String name, {String? reason, Map? userInfo}) {
    throw UnimplementedError(
        'reportException(String name, {String? reason, Map? userInfo}) has not been implemented.');
  }
}
