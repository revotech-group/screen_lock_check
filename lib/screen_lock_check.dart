
import 'screen_lock_check_platform_interface.dart';

class ScreenLockCheck {
  Future<bool> isScreenLockEnabled() {
    return ScreenLockCheckPlatform.instance.isScreenLockEnabled();
  }
}
