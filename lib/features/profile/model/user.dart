class User {
  String firstName;
  String lastName;
  String userName;
  String email;
  String phoneNumber;
  List skills;
  String? photos;

  User({
    this.photos,
    required this.skills,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      photos: json["photo_url"],
      firstName: json["user"]["first_name"],
      lastName: json["user"]["last_name"],
      phoneNumber: json["user"]["phone_number"],
      email: json["user"]["email"],
      userName: json["user"]["username"],
      skills: json["skills"],
    );
  }
}

class Profile {

}
