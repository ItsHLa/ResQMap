import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:resq_map/core/services/http.dart';
import 'package:resq_map/core/services/urls.dart';
import 'package:resq_map/features/profile/model/team.dart';
import 'package:resq_map/features/authentication/utils/auth_service.dart';
import 'package:resq_map/features/profile/model/medical_record.dart';
import 'package:resq_map/features/profile/model/user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> addPersonalData({
    String? bloodType,
    required MedicalRecord record,
    Disease? newDisease,
    Medication? newMedication,
  }) async {
    emit(ProfileLoading());
    try {
      String? token = await AuthService.getAuthToken();
      if (bloodType != null) {
        record.bloodType = bloodType;
      }
      if (newDisease != null && newMedication != null) {
        record.diseases!.add(newDisease);
        record.medications!.add(newMedication);
      }
      var body = record.toJson();
      print(body);
      var response = await HttpService.put(
        token: token,
        uri: updatePersonalInfo,
        body: body,
      );
      if (response["status"] == "200") {
        MedicalRecord record = MedicalRecord.fromJson({
          "blood_type": response["body"]["blood_type"],
          "chronic_diseases": response["body"]["chronic_diseases"],
          "chronic_medications": response["body"]["chronic_medications"],
        });
        emit(UpdatePersonalInfoProfileSuccess(record: record));
      } else {
        emit(ProfileError(msg: 'SomeThing Went Wrong, Try Again Later.'));
      }
    } catch (e) {
      emit(
        ProfileError(
          msg: 'SomeThing Went Wrong, Check Your Internet Connection.',
        ),
      );
    }
  }

  Future<void> removePersonalData(
    MedicalRecord record,
    Disease newDisease,
    Medication newMedication,
  ) async {
    emit(ProfileLoading());
    try {
      String? token = await AuthService.getAuthToken();
      record.diseases!.remove(newDisease);
      record.medications!.remove(newMedication);
      var body = record.toJson();
      var response = await HttpService.put(
        token: token,
        uri: updatePersonalInfo,
        body: body,
      );
      if (response["status"] == "200") {
        MedicalRecord record = MedicalRecord.fromJson({
          "blood_type": response["body"]["blood_type"],
          "chronic_diseases": response["body"]["chronic_diseases"],
          "chronic_medications": response["body"]["chronic_medications"],
        });
        emit(UpdatePersonalInfoProfileSuccess(record: record));
      } else {
        emit(ProfileError(msg: 'SomeThing Went Wrong, Try Again Later.'));
      }
    } catch (e) {
      emit(
        ProfileError(
          msg: 'SomeThing Went Wrong, Check Your Internet Connection.',
        ),
      );
    }
  }

  Future<void> updateUserData(Map<String, dynamic> body) async {
    emit(ProfileLoading());
    try {
      String? token = await AuthService.getAuthToken();
      var response = await HttpService.put(
        token: token,
        uri: updateUserInfo,
        body: body,
      );

      if (response["status"] == "200") {
        emit(UpdateUserInfoProfileSuccess());
      } else {
        print(response["body"]);
        emit(ProfileError(msg: 'SomeThing Went Wrong, Try Again Later.'));
      }
    } catch (e) {
      print(e);
      emit(
        ProfileError(
          msg: 'SomeThing Went Wrong, Check Your Internet Connection.',
        ),
      );
    }
  }

  Future<void> updateProfilePhoto({
    required File photo,
    required String fileName,
  }) async {
    emit(ProfileLoading());
    try {
      String? token = await AuthService.getAuthToken();
      var response = await HttpService.postPhoto(
        token: token!,
        uri: updateProfilePhotoUrl,
        file: photo,
        fileName: fileName,
      );

      if (response["status"] == "200") {
        print(response["body"]);
        emit(
          UpdateProfilePhotoSuccess(
            url: response["body"]["photo_url"],
            msg: response["body"]["msg"],
          ),
        );
      } else {
        print(response["body"]);
        emit(ProfileError(msg: 'SomeThing Went Wrong, Try Again Later.'));
      }
    } catch (e) {
      print(e);
      emit(
        ProfileError(
          msg: 'SomeThing Went Wrong, Check Your Internet Connection.',
        ),
      );
    }
  }

  Future<void> deleteProfilePhoto() async {
    emit(ProfileLoading());
    try {
      String? token = await AuthService.getAuthToken();
      var response = await HttpService.delete(
        token: token!,
        uri: deleteProfilePhotoUrl,
      );

      if (response["status"] == "200") {
        print(response["body"]);
        emit(
          UpdateProfilePhotoSuccess(
            url: response["body"]["photo_url"],
            msg: response["body"]["msg"],
          ),
        );
      } else {
        print(response["body"]);
        emit(ProfileError(msg: 'SomeThing Went Wrong, Try Again Later.'));
      }
    } catch (e) {
      print(e);
      emit(
        ProfileError(
          msg: 'SomeThing Went Wrong, Check Your Internet Connection.',
        ),
      );
    }
  }

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      String? token = await AuthService.getAuthToken();
      var response = await HttpService.get(uri: getProfileUrl, token: token);

      if (response["status"] == "200") {
        print(response["body"]);
        User user = User.fromJson(response["body"]);
        MedicalRecord record = MedicalRecord.fromJson({
          "blood_type": response["body"]["blood_type"],
          "chronic_diseases": response["body"]["chronic_diseases"],
          "chronic_medications": response["body"]["chronic_medications"],
        });
        emit(GetProfileSuccess(med: record, user: user));
      } else {
        emit(ProfileError(msg: 'SomeThing Went Wrong, Try Again Later.'));
      }
    } catch (e) {
      emit(
        ProfileError(
          msg: 'SomeThing Went Wrong, Check Your Internet Connection.',
        ),
      );
    }
  }

  Future<void> deleteAccount() async {
    emit(ProfileLoading());
    try {
      String? token = await AuthService.getAuthToken();
      var response = await HttpService.delete(
        uri: deleteProfileUrl,
        token: token,
      );

      if (response["status"] == "200") {
        await AuthService.clearAllData();
        print(response["body"]);

        emit(DeleteSuccess());
      } else {
        emit(ProfileError(msg: 'SomeThing Went Wrong, Try Again Later.'));
      }
    } catch (e) {
      emit(
        ProfileError(
          msg: 'SomeThing Went Wrong, Check Your Internet Connection.',
        ),
      );
    }
  }

  Future<void> deactivateAccount() async {
    emit(ProfileLoading());
    try {
      String? token = await AuthService.getAuthToken();
      var response = await HttpService.delete(
        uri: deactiveProfileUrl,
        token: token,
      );

      if (response["status"] == "200") {
        await AuthService.clearAllData();
        print(response["body"]);

        emit(DeactivateSuccess());
      } else {
        emit(ProfileError(msg: 'SomeThing Went Wrong, Try Again Later.'));
      }
    } catch (e) {
      emit(
        ProfileError(
          msg: 'SomeThing Went Wrong, Check Your Internet Connection.',
        ),
      );
    }
  }

  Future<void> getTeamSkills() async {
    emit(ProfileLoading());
    try {
      String? token = await AuthService.getAuthToken();
      var response = await HttpService.get(token: token, uri: Urls.GET_TEAM_SKILLS_URL);

      List result = response["body"];
      List<EmergencyTeam> skills =
          result.map((e) => EmergencyTeam.fromJson(e)).toList();
      emit(ProfileLoadedTeamSkills(skills: skills));
    } catch (e) {
      emit(ProfileError(msg: e.toString()));
    }
  }

  Future<void> postTeamSkills(var data) async {
    emit(ProfileLoading());
    try {
      String? token = await AuthService.getAuthToken();
      var response = await HttpService.put(
        token: token,
        uri: Urls.POST_TEAM_SKILLS_URL,
        body: data,
      );

      if (response["status"] == "200") {
        emit(ProfileTeamSkillsPostSuccess());
      } else {
        emit(ProfileError(msg: response["body"]));
      }
    } catch (e) {
      emit(ProfileError(msg: e.toString()));
    }
  }
}
