import 'package:latlong2/latlong.dart';

class Route {
  final List<LatLng> path;
  final LatLng start;
  final LatLng end;
  Route({required this.start, required this.end, required this.path});

  factory Route.fromJson(Map<String,dynamic> json){
    int last = json["path"].lenght-1;
    return Route(
      start: json["path"][0],
      end: json["path"][last],
      path: json["path"]
    );
  }
}
