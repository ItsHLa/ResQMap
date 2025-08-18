part of 'quake_cubit.dart';

@immutable
sealed class WebSocketState {}

final class Loading extends WebSocketState {}

final class LoadingDamaged extends WebSocketState {}

final class Success extends WebSocketState {}

final class GetDamagedUsersSuccess extends WebSocketState {
  final List<User> damagedUsers;
  final bool markedRescued;

  GetDamagedUsersSuccess({required this.damagedUsers, this.markedRescued=false});
}

final class MarkDamagedUsersRescuedSuccess extends WebSocketState {
  final List<User> damagedUsers;

  MarkDamagedUsersRescuedSuccess({required this.damagedUsers});
}

final class GetNewsSuccess extends WebSocketState {
  final List<News> news;

  GetNewsSuccess({required this.news});
}

final class Error extends WebSocketState {
  final String msg;

  Error(this.msg);
}

final class WebSocketInitial extends WebSocketState {}

final class WebSocketConnecting extends WebSocketState {}

final class WebSocketConnected extends WebSocketState {}

final class WebSocketDisconnect extends WebSocketState {}

final class WebSocketLoading extends WebSocketState {}

final class WebSocketProcessData extends WebSocketState {}

final class WebSocketAlertsReceived extends WebSocketState {
  final List<Alert> alerts;
  WebSocketAlertsReceived({required this.alerts});
}

class WebSocketError extends WebSocketState {
  final String message;
  WebSocketError(this.message);
}
