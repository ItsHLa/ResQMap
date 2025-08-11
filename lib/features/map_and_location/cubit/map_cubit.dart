import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';
import 'package:resq_map/core/services/geolocator_service.dart';
import 'package:resq_map/core/services/http.dart';
import 'package:resq_map/core/services/urls.dart';
import 'package:resq_map/features/map_and_location/model/route_model.dart';
import 'package:resq_map/features/authentication/utils/auth_service.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  Future<void> route({required double lat, required double lon}) async {
    emit(MapLoading());
    try {
      String? token = await AuthService.getAuthToken();
      Position start = await GeolocatorService.getLocation();
      print(start.latitude.toStringAsFixed(4));
      print(start.longitude.toStringAsFixed(4));
      var response = await HttpService.post(
        token: token,
        uri: routeUrl,
        body: {
          "start": {"lat": start.latitude.toStringAsFixed(4), "lon": start.longitude.toStringAsFixed(4)},
          "end": {"lat": lat.toStringAsFixed(4), "lon": lon.toStringAsFixed(4)},
        },
      );

      if (response["status"] == "200") {
        List result = response["body"]["path"];
        List<LatLng> path =
            result.map((item) => LatLng(item["lat"], item["lon"])).toList();
        Route route = Route(
          start: path[0],
          end: path[path.length - 1],
          path: path,
        );
        emit(MapSuccess(route: route));
      } else {
        emit(MapError(msg: response["body"]));
      }
    } catch (e) {
      emit(MapError(msg: e.toString()));
    }
  }

  Future<void> trackLocation({required double lat, required double lon}) async {
    String? token = await AuthService.getAuthToken();

    var response = await HttpService.post(
      token: token,
      uri: Urls.TRAK_LOCATION_URL,
      body: {"lat": lat, "lon": lon},
    );
    print(response);
  }
}
