part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthEmailVerify extends AuthState {
  final Map<String, dynamic>? data;

  AuthEmailVerify({this.data});
}

final class AuthLoading extends AuthState {}

final class AuthLogOutLoading extends AuthState {}

final class AuthAuditLoading extends AuthState {}

final class AuthSignedUp extends AuthState {}

final class AuthLogedIn extends AuthState {}

final class AuthLogedOut extends AuthState {}

final class AuthError extends AuthState {
  final String msg;

  AuthError({required this.msg});
}

final class AuthPasswordReset extends AuthState {}

final class AuthChangePassword extends AuthState {}

final class AuthLoadedAudits extends AuthState {
  final List<AuthAudit> audits;

  AuthLoadedAudits({required this.audits});
}

final class AuthTeamSkillsPostSuccess extends AuthState {}

final class AuthGetUserData extends AuthState {
  final Map<String, dynamic> data;

  AuthGetUserData({required this.data});
}
