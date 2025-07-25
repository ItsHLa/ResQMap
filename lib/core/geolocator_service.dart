import 'package:geolocator/geolocator.dart';
enum LocationServiceStatus {
  enabled,
  disabled,
  permissionDenied,
  permissionDeniedForever,
}
abstract class  GeolocatorService {
  static Future<LocationServiceStatus> checkPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationServiceStatus.disabled;
    }
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationServiceStatus.permissionDenied;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationServiceStatus.permissionDeniedForever;
    }

    return LocationServiceStatus.enabled;
  }

  static Future<Position> getLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
