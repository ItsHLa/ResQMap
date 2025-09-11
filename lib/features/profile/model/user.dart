import 'package:resq_map/features/map_and_location/model/location_model.dart';

class User {
  int id;
  String firstName;
  String lastName;
  String userName;
  String email;
  String phoneNumber;
  List skills;
  String? photos;
  String? status;
  Location? location;
  String? lastSeen;
  bool isOnline;

  User({
    required this.id,
    this.photos,
    this.lastSeen,
    this.location,
    required this.skills,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    this.status,
    this.isOnline = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["user"]["id"] ?? json["id"],
      photos: json["photo_url"],
      firstName: json["user"]["first_name"] ?? json["first_name"],
      lastName: json["user"]["last_name"] ?? json["last_name"],
      phoneNumber: json["user"]["phone_number"] ?? "",
      email: json["user"]["email"] ?? "",
      userName: json["user"]["username"] ?? json["username"],
      skills: json["skills"] ?? [],
      status: json["status"],
      location: Location.fromJson(json["last_location"] ?? {}),
      lastSeen: json["user"]["last_seen"],
      isOnline: json["user"]["is_online"],
    );
  }
}

class Profile {}
