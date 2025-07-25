class AuthAudit {
  final String createdAt;
  final String action;
  final String ipAddress;

  AuthAudit({
    required this.createdAt,
    required this.action,
    required this.ipAddress,
  });

  factory AuthAudit.fromJson(Map<String, dynamic> json) {
    return AuthAudit(
      createdAt: json["created_at"],
      action: json["action"],
      ipAddress: json["ip_address"],
    );
  }
}
