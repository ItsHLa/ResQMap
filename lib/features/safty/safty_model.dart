class SaftyModel {
  final String status;
  final String lastLocation;

  SaftyModel({required this.status, required this.lastLocation});

  factory SaftyModel.toJson(Map<String, dynamic> json) {
    return SaftyModel(
      status : json["status"] ,
      lastLocation: json["last_location"],
    );
  }
}
