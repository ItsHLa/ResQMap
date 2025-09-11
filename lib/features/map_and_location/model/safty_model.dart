import 'package:resq_map/features/map_and_location/model/location_model.dart';

class SaftyModel {
  final String status;
  final Location? location;

  SaftyModel({required this.status, required this.location});

  

  factory SaftyModel.toJson(Map<String, dynamic> json) {
    return SaftyModel(
      status: json["status"] ?? "Unknown",
      location: Location.fromJson(json["last_location"] ?? {}),
    );
  }
}
