class SaftyModel {
  final bool isMarkedSafe;
  final String lastLocation;

  SaftyModel({required this.isMarkedSafe, required this.lastLocation});

  factory SaftyModel.toJson(Map<String, dynamic> json) {
    return SaftyModel(
      isMarkedSafe: json["is_marked_safe"],
      lastLocation: json["last_location"],
    );
  }
}
