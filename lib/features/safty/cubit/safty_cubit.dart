import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:resq_map/core/services/http.dart';
import 'package:resq_map/core/services/urls.dart';
import 'package:resq_map/features/authentication/utils/auth_service.dart';
import 'package:resq_map/features/earthquake/http_quake_requests.dart';
import 'package:resq_map/features/safty/safty_model.dart';

part 'safty_state.dart';

class SaftyCubit extends Cubit<SaftyState> {
  SaftyCubit() : super(SaftyInitial());

  Future<void> markSafe(bool status) async {
    try {
      // String? token = await AuthService.getAuthToken();
      // var response = await HttpService.put(
      //   token: token,
      //   uri: Urls.MARK_SAFE_URL,
      //   body: {"is_marked_safe": status},
      // );
      var response = HttpQuakeRequests.markSafe(status);
      if (response["status"] == "200") {
        print(response["body"]);
        emit(MarkSafeSuccess());
      } else {
        print("Failed");
        emit(MarkSafeFailed());
      }
    } catch (e) {
      print("SomeThing Went Wrong:$e");
    }
  }

  Future<void> getUserStatus() async {
    emit(Loading());
    try {
      String? token = await AuthService.getAuthToken();
      var response = await HttpService.get(
        uri: Urls.GET_USER_STATUS,
        token: token,
      );

      if (response["status"] == "200") {
        print(response["body"]);
        var json = response["body"];
        final status = SaftyModel.toJson(json);
        print(status);
        emit(UserStatusSuccess(mySafty: status));
      } else {
        print("Failed");
        emit(UserStatusFailed(msg: 'SomeThing Went Wrong, Try Again Later.'));
      }
    } catch (e) {
      print(e.toString());
      emit(
        UserStatusFailed(
          msg: 'SomeThing Went Wrong, Check Your Internet Connection.',
        ),
      );
    }
  }
}
