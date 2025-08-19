class Location {
  String? id;
  double? lat;
  double? lon;
  String? fulladdress;
  double? distance;
  Location({this.id,this.lat, this.lon, this.distance, this.fulladdress});

  factory Location.fromJson(json) {
    return Location(
      id : json["id"],
      lat: json["lat"],
      lon: json["lon"],
      distance: json["distance"],
      fulladdress: json["address"],
    );
  }
}

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
      // updatedAt: DateTime.parse(json["updated_at"])
    );
  }
}
