part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}
final class ProfileLoadingTeamSkills extends ProfileState {}
final class ProfileLoadedTeamSkills extends ProfileState {
  final List<EmergencyTeam> skills;

  ProfileLoadedTeamSkills({required this.skills});
}

final class UpdateUserInfoProfileSuccess extends ProfileState {}

final class ProfileTeamSkillsPostSuccess extends ProfileState {}

final class UpdatePersonalInfoProfileSuccess extends ProfileState {
  final MedicalRecord record;
  UpdatePersonalInfoProfileSuccess({required this.record});
}

final class UpdateProfilePhotoSuccess extends ProfileState {
  final String msg;
  final String url;
  UpdateProfilePhotoSuccess({required this.msg, required this.url});
}

final class GetProfileSuccess extends ProfileState {
  final User user;
  final MedicalRecord med;

  GetProfileSuccess({required this.med, required this.user});
}

final class MedicalSuccess extends ProfileState {
  final MedicalRecord med;

  MedicalSuccess({required this.med});
}

final class DeleteSuccess extends ProfileState {}

final class DeactivateSuccess extends ProfileState {}

// ignore: must_be_immutable
final class ProfileError extends ProfileState {
  final String msg;
  MedicalRecord? record;
  ProfileError({required this.msg, this.record});
}

final class ProfileUpdate extends ProfileState {}
