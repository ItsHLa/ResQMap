part of 'safty_cubit.dart';

@immutable
sealed class SaftyState {}

final class SaftyInitial extends SaftyState {}

final class Loading extends SaftyState {}

final class MySaftyLoading extends SaftyState {}

final class SearchUserLoading extends SaftyState {}

final class Error extends SaftyState {}

final class MarkSafeSuccess extends SaftyState {}

final class MarkSafeFailed extends SaftyState {}

final class UserStatusSuccess extends SaftyState {
  final SaftyModel myStatus;
  final List<User> mySafty;

  UserStatusSuccess({required this.myStatus, required this.mySafty});
}

final class GetSearchUserSuccess extends SaftyState {
  final List<User> users;
  final bool addedToSafty;
  // final bool removeFromSafty;
  GetSearchUserSuccess( {required this.users, this.addedToSafty = false});
}

final class AddedSaftyUsersSuccess extends SaftyState {
  final List<User> users;
  final User addedToSafty;
  // final bool removeFromSafty;
  AddedSaftyUsersSuccess( {required this.users,  required this.addedToSafty });
}

final class DeleteSaftyUsersSuccess extends SaftyState {
  final List<User> users;

  DeleteSaftyUsersSuccess({required this.users});
}

final class MySaftyError extends SaftyState {
  final String msg;

  MySaftyError({required this.msg});
}
