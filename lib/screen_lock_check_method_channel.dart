import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'screen_lock_check_platform_interface.dart';

/// An implementation of [ScreenLockCheckPlatform] that uses method channels.
class MethodChannelScreenLockCheck extends ScreenLockCheckPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('screen_lock_check');

  @override
  Future<bool> isScreenLockEnabled() async {
    final isScreenLockEnabled = await methodChannel.invokeMethod<bool>('isScreenLockEnabled') ?? false;
    return isScreenLockEnabled;
  }
}
