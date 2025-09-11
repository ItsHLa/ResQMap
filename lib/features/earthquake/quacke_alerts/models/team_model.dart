import 'package:resq_map/features/profile/model/user.dart';

class TeamModel {
  final User user;
  final List? role;
  final String? joinAt;

  TeamModel({required this.user, required this.role, required this.joinAt});

  factory TeamModel.fromJson(json) {
    Map<String,dynamic> userjson = {
      "user": json["user"],
      "photo_url": json["user"]["photo_url"],
    };
    return TeamModel(
      user: User.fromJson(userjson),
      joinAt: json["joined_at"] ?? 'Unknown',
      role: json["role"],
    );
  }

  static List<TeamModel> jsonToList(List data) {
    return data.map((json) => TeamModel.fromJson(json)).toList();
  }
}
