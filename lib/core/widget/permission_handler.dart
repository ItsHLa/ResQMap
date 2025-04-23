import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerUtil {
  static Future<bool> requestLocation() async {
    final status = await Permission.location.request();

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      return false;
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false; 
    }

    return false; 
  }
}
