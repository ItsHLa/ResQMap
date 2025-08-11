part of 'map_cubit.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

final class MapLoading extends MapState {}

final class MapSuccess extends MapState {
  final Route route;

  MapSuccess({required this.route});
}

final class MapError extends MapState {
  final String msg;
  MapError({required this.msg});
}
