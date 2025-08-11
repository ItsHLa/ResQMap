import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:resq_map/features/home/settings_service.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  Future<void> darkModeOn({required bool darkOn}) async {
    await SettingsService.saveDarkMode(darkMode: darkOn);

    if (darkOn) {
      emit(DarkModeNight());
    } else {
      emit(DarkModeLight());
    }
  }

  Future<void> trackingLocationOn({ required bool trackingOn}) async {
   
    await SettingsService.saveTrackingLocation(trackingLocation: trackingOn);

    if (trackingOn) {
      emit(TrackingOn());
    } else {
      emit(TrackingOff());
    }
  }

  Future<void> getSettings() async {
    bool trackingModeOn = await SettingsService.getTrackingLocation() ?? false;
    bool darkModeOn = await SettingsService.getDarkMode() ?? false;
    emit(AppSettings(darkMode: darkModeOn, tracking: trackingModeOn));
  }
}
