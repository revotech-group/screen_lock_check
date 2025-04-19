import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'screen_lock_check_method_channel.dart';

abstract class ScreenLockCheckPlatform extends PlatformInterface {
  /// Constructs a ScreenLockCheckPlatform.
  ScreenLockCheckPlatform() : super(token: _token);

  static final Object _token = Object();

  static ScreenLockCheckPlatform _instance = MethodChannelScreenLockCheck();

  /// The default instance of [ScreenLockCheckPlatform] to use.
  ///
  /// Defaults to [MethodChannelScreenLockCheck].
  static ScreenLockCheckPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ScreenLockCheckPlatform] when
  /// they register themselves.
  static set instance(ScreenLockCheckPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> isScreenLockEnabled() {
    throw UnimplementedError('isScreenLockEnabled() has not been implemented.');
  }
}
