part of 'safty_cubit.dart';

@immutable
sealed class SaftyState {}

final class SaftyInitial extends SaftyState {}

final class Loading extends SaftyState {}

final class MarkSafeSuccess extends SaftyState {}

final class MarkSafeFailed extends SaftyState {}

final class UserStatusSuccess extends SaftyState {
  final SaftyModel mySafty;

  UserStatusSuccess({required this.mySafty});
}

final class UserStatusFailed extends SaftyState {
  final String msg;

  UserStatusFailed({required this.msg});
}
