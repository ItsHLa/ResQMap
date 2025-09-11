import 'package:resq_map/features/earthquake/quacke_alerts/models/team_model.dart';
import 'package:resq_map/features/map_and_location/model/location_model.dart';

class Alert {
  String? id;
  Location? location;
  String? dangerLevel;
  String? teamStatus;
  List? tags;
  List<TeamModel> teams;
  String? totalDamagedUsers;
  String? totalReportsCount;
  DateTime? updatedAt;

  Alert({
    this.id,
    this.teams = const [],
    this.updatedAt,
    this.tags,
    this.location,
    this.dangerLevel,
    this.teamStatus,
    this.totalDamagedUsers,
    this.totalReportsCount
  });

  factory Alert.fromJson(json) {
    return Alert(
      id: json["id"].toString(),
      tags: json["tags"],
      teams: TeamModel.jsonToList(json["team"] ??[]),
      location: Location.fromJson(json["location"]),
      dangerLevel: json["danger_level"].toString(),
      teamStatus: json["team_status"],
      totalDamagedUsers:json["damaged_users"].toString(),
         totalReportsCount:  json["total_count"].toString(),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }
}
