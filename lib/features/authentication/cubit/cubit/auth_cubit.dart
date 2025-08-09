import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:resq_map/core/services/http.dart';
import 'package:resq_map/core/services/urls.dart';

import 'package:resq_map/features/authentication/model/auth_audit.dart';
import 'package:resq_map/features/authentication/utils/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> generateOTP(String url, Map<String, dynamic> data) async {
    print(data);
    emit(AuthLoading());
    try {
      var response = await HttpService.post(
        uri: url,
        body: {"email": data['email']},
      );
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

      if (response["status"] == "200") {
        AuthService.saveTokenData(
          refreshToken: response["body"]["refresh"],
          token: response["body"]["access"],
        );
        emit(AuthSignedUp());
      } else {
        emit(AuthError(msg: response["body"]["error"]));
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

  Future<void> logOut() async {
    emit(AuthLoading());
    try {
      var refresh = await AuthService.getRefreshToken();
      var token = await AuthService.getAuthToken();
      var response = await HttpService.post(
        token: token!,
        uri: logOutUrl, body: {
        "refresh" : refresh
      });
      if (response["status"] == "200") {
        await AuthService.clearAllData();
        emit(AuthLogedOut());
      } else {
        emit(AuthError(msg: response["body"]["error"]));
      }
    } catch (e) {
      emit(AuthError(msg: e.toString()));
    }
  }

  Future<void> getAuthAudit() async {
    emit(AuthLoading());
    try {
      String? token = await AuthService.getAuthToken();
      var response = await HttpService.get(token: token, uri: authAuditUrl);

      List result = response["body"];
      List<AuthAudit> audits =
          result.map((e) => AuthAudit.fromJson(e)).toList();
      emit(AuthLoadedAudits(audits: audits));
    } catch (e) {
      emit(AuthError(msg: e.toString()));
    }
  }

  Future<void> changePassword(Map<String, dynamic> data) async {
    print(data);
    emit(AuthLoading());
    try {
      String? token = await AuthService.getAuthToken();
      var response = await HttpService.post(
        token: token,
        uri: changePasswordUrl,
        body: data,
      );
      print(response);
      if (response["status"] == "200") {
        emit(AuthChangePassword());
      } else {
        emit(AuthError(msg: response["body"]["error"]));
      }
    } catch (e) {
      emit(AuthError(msg: e.toString()));
    }
  }
}
