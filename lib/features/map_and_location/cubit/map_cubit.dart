import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';
import 'package:resq_map/core/services/geolocator_service.dart';
import 'package:resq_map/core/services/http.dart';
import 'package:resq_map/core/services/urls.dart';
import 'package:resq_map/features/earthquake/http_quake_requests.dart';
import 'package:resq_map/features/map_and_location/model/route_model.dart';
import 'package:resq_map/features/authentication/utils/auth_service.dart';
import 'package:resq_map/features/map_and_location/model/safty_model.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  Future<void> markSafe(String status) async {
    emit(MarkSafeLoading());
    try {
      var response = await HttpQuakeRequests.markStatus(status);
      if (response["status"] == "200") {
        print(response["body"]);
        emit(MarkSafeSuccess());
      } else {
        print("Failed");
        emit(MarkSafeFailed(msg: "Check Your Internet Connection"));
      }
    } catch (e) {
      print(e.toString());
      emit(MarkSafeFailed(msg: "SomeThing Went Wrong:$e"));
      print("SomeThing Went Wrong:$e");
    }
  }

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
          "start": {
            "lat": start.latitude.toStringAsFixed(4),
            "lon": start.longitude.toStringAsFixed(4),
          },
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

  Future<void> getUserStatus() async {
    emit(MapLoading());
    try {
      String? token = await AuthService.getAuthToken();
      var getUserStatusResponse = await HttpService.get(
        uri: Urls.GET_USER_STATUS,
        token: token,
      );
      if (getUserStatusResponse["status"] == "200") {
        var json = getUserStatusResponse["body"];
        final status = SaftyModel.toJson(json);
        print(status);
        emit(MapUserInfo(userStatus: status));
      } else {
        emit(MapError(msg: 'Check Your Internet Connection!'));
      }
    } catch (e) {
      print(e.toString());
      emit(MapError(msg: e.toString()));
    }
  }

  Future<void> trackLocation({required Position position}) async {
    String? token = await AuthService.getAuthToken();
    final lat = position.latitude.toStringAsFixed(6);
    final lon = position.longitude.toStringAsFixed(6);

    print(lat);
    print(lon);

    var response = await HttpService.post(
      token: token,
      uri: Urls.TRAK_LOCATION_URL,
      body: {"lat": lat, "lon": lon},
    );
    print(response);
  }
}
