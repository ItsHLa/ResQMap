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
      fulladdress: json["address"] ?? "Unknown",
    );
  }
}