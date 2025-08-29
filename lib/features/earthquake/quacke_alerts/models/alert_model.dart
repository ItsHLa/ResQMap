
import 'package:resq_map/features/map_and_location/model/location_model.dart';

class Alert {
  String? id;
  Location? location;
  String? dangerLevel;
  String? teamStatus;
  List? tags;
  String? totalDamagedUsers;
  DateTime? updatedAt;

  Alert({
    this.id,
    this.updatedAt,
    this.tags,
    this.location,
    this.dangerLevel,
    this.teamStatus,
    this.totalDamagedUsers,
  });

  

  factory Alert.fromJson(json) {
    return Alert(
      id: json["id"].toString(),
      tags: json["tags"],
      location: Location.fromJson(json["location"]),
      dangerLevel: json["danger_level"].toString(),
      teamStatus: json["team_status"],
      totalDamagedUsers: (json["damaged_users"] + json["total_count"]).toString(),
      updatedAt: DateTime.parse(json["updated_at"])
    );
  }
}
