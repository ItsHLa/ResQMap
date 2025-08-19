import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:resq_map/core/services/http.dart';
import 'package:resq_map/core/services/urls.dart';
import 'package:resq_map/features/authentication/utils/auth_service.dart';
import 'package:resq_map/features/earthquake/http_quake_requests.dart';
import 'package:resq_map/features/profile/model/user.dart';
import 'package:resq_map/features/safty/safty_model.dart';

part 'safty_state.dart';

class SaftyCubit extends Cubit<SaftyState> {
  SaftyCubit() : super(SaftyInitial());

  Future<void> markSafe(bool status) async {
    try {
      var response = HttpQuakeRequests.markStatus(status ? "Safe" : "UnSafe");
      if (response["status"] == "200") {
        print(response["body"]);
        emit(MarkSafeSuccess());
      } else {
        print("Failed");
        emit(MySaftyError(msg: "Check Your Internet Connection"));
      }
    } catch (e) {
      emit(MySaftyError(msg: "SomeThing Went Wrong:$e"));
      print("SomeThing Went Wrong:$e");
    }
  }

  Future<void> getUserStatus() async {
    emit(Loading());
    try {
      String? token = await AuthService.getAuthToken();
      var getUserStatusResponse = await HttpService.get(
        uri: Urls.GET_USER_STATUS,
        token: token,
      );

      var getSaftyUsersResponse = await HttpService.get(
        uri: Urls.GET_SAFTY_USERS,
        token: token,
      );

      if (getUserStatusResponse["status"] == "200" &&
          getSaftyUsersResponse["status"] == "200") {
        var json = getUserStatusResponse["body"];
        final status = SaftyModel.toJson(json);
        List data = getSaftyUsersResponse["body"];
        List<User> safty = data.map((json) => User.fromJson(json)).toList();
        print(status);
        emit(UserStatusSuccess(myStatus: status, mySafty: safty));
      } else {
        emit(Error());
      }
    } catch (e) {
      print(e.toString());
      emit(Error());
    }
  }

  Future<void> searchUsers({required String search}) async {
    emit(SearchUserLoading());
    try {
      String? token = await AuthService.getAuthToken();
      var response = await HttpService.get(
        uri: "${Urls.SEARCH_USERS}$search",
        token: token,
      );

     

      if (response["status"] == "200" 
         ) {
        
        List data = response["body"];
        List<User> users = data.map((json) => User.fromJson(json)).toList();
        print(users);
        emit(GetSearchUserSuccess(users: users));
      } else {
        emit(Error());
      }
    } catch (e) {
      print(e.toString());
      emit(Error());
    }
  }

  Future<void> addToMySafty({
    required User user,
    required List<User> users,
  }) async {
    emit(MySaftyLoading());
    try {
      String? token = await AuthService.getAuthToken();
      
      var response = await HttpService.put(
        token: token,
        uri: Urls.ADD_TO_MY_SAFTY,
        body: {"my_safty": [user.id]},
      );

      if (response["status"] == "200") {
        users.remove(user);
        emit(AddedSaftyUsersSuccess(users: users, addedToSafty: user));
      } else {
        emit(MySaftyError(msg: "Check Your Internet Connection!"));
      }
    } catch (e) {
      emit(MySaftyError(msg: e.toString()));
    }
  }

  Future<void> removeFromMySafty({
    required User user,
    required List<User> users,
  }) async {
    emit(MySaftyLoading());
    try {
      String? token = await AuthService.getAuthToken();
      var response = await HttpService.delete(
        token: token,
        uri: Urls.DELETE_FROM_MY_SAFTY,
        body: {
          "my_safty": [user.id],
        },
      );

      if (response["status"] == "200") {
        users.remove(user);
        emit(DeleteSaftyUsersSuccess(users: users));
      } else {
        emit(MySaftyError(msg: "Check Your Internet Connection!"));
      }
    } catch (e) {
      emit(MySaftyError(msg: e.toString()));
    }
  }
}
