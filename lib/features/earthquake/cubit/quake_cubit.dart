import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:resq_map/core/services/geolocator_service.dart';
import 'package:resq_map/core/services/http.dart';
import 'package:resq_map/core/services/web_socket_channels.dart';
import 'package:resq_map/features/authentication/utils/auth_service.dart';
import 'package:resq_map/features/earthquake/quake_news/model/news.dart';
import 'package:resq_map/features/profile/model/user.dart';
import '../../../core/services/urls.dart';
import '../quacke_alerts/models/alert_model.dart';
part 'quake_state.dart';

class WebSocketCubit extends Cubit<WebSocketState> {
  static final WebSocketCubit _instance = WebSocketCubit._internal();
  factory WebSocketCubit() => _instance;
  WebSocketCubit._internal() : super(WebSocketInitial());

  final _webSocket = WebSocketChannels();
  StreamSubscription<dynamic>? _messageSubscription;

  Future<void> connect(String token) async {
    if (state is WebSocketConnected || _webSocket.isConnected) return;

    debugPrint("Connecting WebSocket...");
    emit(WebSocketConnecting());

    try {
      await _webSocket.connect(token, Urls.GET_ALERT_URL);
      emit(WebSocketConnected());
    } catch (e) {
      debugPrint("WebSocket connection error: $e");
      emit(WebSocketError("Connection failed: ${e.toString()}"));
      rethrow;
    }
  }

  Future<void> postTeamStatus({
    required String alertId,
    required String locationId,
    required String status
  }) async {
    emit(Loading());
    try {
      String? token = await AuthService.getAuthToken();
      var response = await HttpService.post(
        token: token,
        uri: Urls.POST_ASSIST_URL,
        body: {
          "id" :alertId,
          "location_id" : locationId,
          "status" : status 
        },
      );

      if (response["status"] == "200") {
        emit(Success());
      } else {
        emit(Error(response["body"]));
      }
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> postDamagedUserStatus({required int userId, required List<User> users}) async {
    emit(LoadingDamaged());
    try {
      String? token = await AuthService.getAuthToken();
      var response = await HttpService.post(
        token: token,
        uri: Urls.POST_DAMAGED_USER_RESQUED_URL,
        body: {"user_id" :userId },
      );

      if (response["status"] == "200") {
        List<User> result = users.where((element) =>element.id != userId ,).toList();
        emit(GetDamagedUsersSuccess(damagedUsers:result,markedRescued: true));
      } else {
        emit(Error(response["body"]));
      }
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> getAlerts() async {
    try {
      // Ensure connection
      if (state is! WebSocketConnected) {
        final token = await AuthService.getAuthToken();
        if (token == null) {
          emit(WebSocketError("Authentication required"));
          return;
        }
        await connect(token);
      }

      emit(WebSocketLoading());

      // Cancel any existing subscription
      await _messageSubscription?.cancel();
      Position start = await GeolocatorService.getLocation();
      // Send request
      _webSocket.sendMessage(
        jsonEncode({
          "type": "get_alerts",
          "lat": start.latitude.toStringAsFixed(4),
          "lon": start.longitude.toStringAsFixed(4),
        }),
      );

      // Set up new subscription
      _messageSubscription = _webSocket.getMessages().listen(
        (message) {
          try {
            final json = jsonDecode(message);
            final locations = json['locations'] as List;

            debugPrint("Received alerts: $locations");

            final alerts =
                locations.map((item) => Alert.fromJson(item)).toList();
            emit(WebSocketAlertsReceived(alerts: alerts));
          } catch (e) {
            debugPrint("Error processing message: $e");
            emit(WebSocketError("Failed to process alerts"));
          }
        },
        onError: (error) {
          debugPrint("WebSocket error: $error");
          emit(WebSocketError("Connection error"));
        },
      );
    } catch (e) {
      debugPrint("Error in getAlerts: $e");
      emit(WebSocketError("Failed to fetch alerts"));
    }
  }

  Future<void> getDamagedUsers(String? location_id) async {
    emit(Loading());
    try {
      String? token = await AuthService.getAuthToken();
      var response = await HttpService.get(
        uri: "${Urls.GET_DAMAGED_USERS_URL}$location_id",
        token: token,
      );

      if (response["status"] == "200") {
        print(response["body"]);
        List result = response["body"];
        final damagedUsers =
            result.map((json) => User.fromJson(json)).toList();

        emit(GetDamagedUsersSuccess(damagedUsers: damagedUsers));
      } else {
        emit(Error('Check Your Internet Connection'));
      }
    } catch (e) {
      print(e.toString());
      emit(Error('SomeThing Went Wrong, Check Your Internet Connection.'));
    }
  }

  Future<void> getQuakeNews() async {
    emit(Loading());
    try {
      String? token = await AuthService.getAuthToken();
      var response = await HttpService.get(
        uri: Urls.QUACK_NEWS_URL,
        token: token,
      );

      if (response["status"] == "200") {
        print(response["body"]);
        List rep = response["body"];
        final news = rep.map((item) => News.fromJson(item)).toList();

        emit(GetNewsSuccess(news: news));
      } else {
        print("Failed");
        emit(Error('SomeThing Went Wrong, Try Again Later.'));
      }
    } catch (e) {
      print(e.toString());
      emit(Error('SomeThing Went Wrong, Check Your Internet Connection.'));
    }
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    _webSocket.disconnect();
    return super.close();
  }
}
