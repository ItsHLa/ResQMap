class EmergencyTeam {
  final String id;
  final String teamName;
  final String coreFunction;

  EmergencyTeam({
    required this.id,
    required this.teamName,
    required this.coreFunction});

  factory EmergencyTeam.fromJson(Map<String, dynamic> json) {
    return EmergencyTeam(
      id: json["id"].toString(),
      teamName: json['team_name'],
      coreFunction: json['core_function'],
    );
  }
}
