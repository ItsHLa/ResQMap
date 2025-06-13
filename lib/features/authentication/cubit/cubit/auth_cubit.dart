import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:resq_map/core/http.dart';
import 'package:resq_map/core/urls.dart';
import 'package:resq_map/features/authentication/model/team_skill_model/team.dart';
import 'package:resq_map/features/authentication/utils/auth_service.dart';
import 'package:resq_map/features/authentication/model/user_models/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> generateOTP(String url, Map<String, dynamic> data) async {
    print(data);
    emit(AuthLoading());
    try {
      var response = await HttpService.post(uri: url, body: {"email": data['email']});
      print(response);
      if (response["status"] == "200") {
        emit(AuthEmailVerify(data: data));
      } else {
        emit(AuthError(msg: response["body"]["error"]));
      }
    } catch (e) {
      emit(AuthError(msg: e.toString()));
    }
  }

  Future<void> resetPassword(Map<String, dynamic> data) async {
    print(data);
    emit(AuthLoading());
    try {
      var response = await HttpService.post(uri: resetCompleteUrl, body: data);

      print(response);
      if (response["status"] == "200") {
        emit(AuthPasswordReset());
      } else {
        emit(AuthError(msg: response["body"]["error"]));
      }
    } catch (e) {
      emit(AuthError(msg: e.toString()));
    }
  }

  Future<void> signUp(Map<String, dynamic> data) async {
    print(data);
    emit(AuthLoading());
    try {
      var response = await HttpService.post(uri: signUpUrl, body: data);

      User user = User(
        firstName: data["first_name"],
        lastName: data["last_name"],
        email: data["email"],
        password: data["password"],
        phoneNumber: data["phone_number"],
        userName: data["username"],
      );

      if (response["status"] == "200") {
        AuthService.saveUserData(user: user);

        AuthService.saveTokenData(
          refreshToken: response["body"]["refresh"],
          token: response["body"]["access"],
        );
        emit(AuthSignedUp());
      } else {
        emit(AuthError(msg: response["body"]));
      }
    } catch (e) {
      emit(AuthError(msg: e.toString()));
    }
  }

  Future<void> logIn(Map<String, dynamic> data) async {
    print(data);
    emit(AuthLoading());
    try {
      var response = await HttpService.post(uri: logInUrl, body: data);

      print(response);
      if (response["status"] == "200") {
        AuthService.saveTokenData(
          refreshToken: response["body"]["refresh"],
          token: response["body"]["access"],
        );
        emit(AuthLogedIn());
      } else {
        emit(AuthError(msg: response["body"]["error"]));
      }
    } catch (e) {
      emit(AuthError(msg: e.toString()));
    }
  }

  Future<void> logOut(Map<String, dynamic> data) async {
    emit(AuthLoading());
    try {
      var response = await HttpService.post(uri: logOutUrl, body: data);
      emit(AuthLogedOut());
    } catch (e) {
      emit(AuthError(msg: e.toString()));
    }
  }

  Future<void> getTeamSkills() async {
    emit(AuthLoading());
    try {
      String? token = await AuthService.getAuthToken();
      var response = await HttpService.get(token: token, uri: getTeamSkillsUrl);

      List result = response["body"];
      List<EmergencyTeam> skills =
          result.map((e) => EmergencyTeam.fromJson(e)).toList();
      emit(AuthLoadedTeamSkills(skills: skills));
    } catch (e) {
      emit(AuthError(msg: e.toString()));
    }
  }

  Future<void> postTeamSkills(var data) async {
    emit(AuthLoading());
    try {
      String? token = await AuthService.getAuthToken();
      var response = await HttpService.put(
        token: token,
        uri: postTeamSkillsUrl,
        body: data,
      );

      if (response["status"] == "200") {
        emit(AuthTeamSkillsPostSuccess());
      } else {
        emit(AuthError(msg: response["body"]));
      }
    } catch (e) {
      emit(AuthError(msg: e.toString()));
    }
  }
}
