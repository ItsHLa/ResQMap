class News {
  final double lat;
  final double lon;
  final double mag;
  final double depth;
  final String place;
  final String time;

  News({
    required this.lat,
    required this.lon,
    required this.mag,
    required this.depth,
    required this.place,
    required this.time,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    List time = json["time"].split(",");
    return News(
      lat: json["lat"],
      lon: json["lon"],
      mag: json["mag"].toDouble(),
      depth: json["depth"].toDouble(),
      place: json["place"],
      time: "${time[0]} - ${time[2]}",
    );
  }
}
