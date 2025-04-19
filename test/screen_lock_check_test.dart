import 'package:flutter_test/flutter_test.dart';
import 'package:screen_lock_check/screen_lock_check.dart';
import 'package:screen_lock_check/screen_lock_check_platform_interface.dart';
import 'package:screen_lock_check/screen_lock_check_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockScreenLockCheckPlatform
    with MockPlatformInterfaceMixin
    implements ScreenLockCheckPlatform {

  @override
  Future<bool?> isScreenLockEnabled() => Future.value(true);
}

void main() {
  final ScreenLockCheckPlatform initialPlatform = ScreenLockCheckPlatform.instance;

  test('$MethodChannelScreenLockCheck is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelScreenLockCheck>());
  });

  test('isScreenLockEnabled', () async {
    ScreenLockCheck screenLockCheckPlugin = ScreenLockCheck();
    MockScreenLockCheckPlatform fakePlatform = MockScreenLockCheckPlatform();
    ScreenLockCheckPlatform.instance = fakePlatform;

    expect(await screenLockCheckPlugin.isScreenLockEnabled(), true);
  });
}
