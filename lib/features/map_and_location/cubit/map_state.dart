part of 'map_cubit.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

final class MapLoading extends MapState {}

final class MarkSafeSuccess extends MapState {}

final class MarkSafeFailed extends MapState {
   final String msg;

  MarkSafeFailed({required this.msg});

}

final class MarkSafeLoading extends MapState {


}
final class MapUserInfo extends MapState {
  final SaftyModel userStatus;

  MapUserInfo({required this.userStatus});
}

final class MapSuccess extends MapState {
  final Route route;

  MapSuccess({required this.route});
}

final class MapError extends MapState {
  final String msg;
  MapError({required this.msg});
}
