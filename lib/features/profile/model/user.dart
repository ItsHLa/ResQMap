class User {
  int id;
  String firstName;
  String lastName;
  String userName;
  String email;
  String phoneNumber;
  List? skills;
  String? photos;
  String? status;

  User({
    required this.id,
    this.photos,
    required this.skills,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    this.status
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["user"]["id"],
      photos: json["photo_url"],
      firstName: json["user"]["first_name"],
      lastName: json["user"]["last_name"],
      phoneNumber: json["user"]["phone_number"],
      email: json["user"]["email"],
      userName: json["user"]["username"],
      skills: json["skills"],
      status: json["status"]
    );
  }
}

class Profile {}
