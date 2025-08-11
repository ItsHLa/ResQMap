import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:resq_map/core/constants/themes.dart';
import 'package:resq_map/core/services/fierbase_notifications.dart';
import 'package:resq_map/features/earthquake/cubit/quake_cubit.dart';
import 'package:resq_map/features/authentication/utils/auth_service.dart';
import 'package:resq_map/features/authentication/cubit/cubit/auth_cubit.dart';
import 'package:resq_map/features/home/cubit/cubit/settings_cubit.dart';
import 'package:resq_map/features/home/settings_service.dart';
import 'package:resq_map/features/map_and_location/cubit/map_cubit.dart';
import 'package:resq_map/features/profile/cubit/profile_cubit.dart';
import 'package:resq_map/features/safty/cubit/safty_cubit.dart';
import 'package:resq_map/features/splash/pages/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseNotificationService.initialize();

  await Hive.initFlutter();
  await SettingsService.init();
  await AuthService.init();

  SettingsService.trackLocation = await SettingsService.getTrackingLocation() ?? false;
  SettingsService.darkMode = await SettingsService.getDarkMode() ?? false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WebSocketCubit>(create: (context) => WebSocketCubit()),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<MapCubit>(create: (context) => MapCubit()),
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
        BlocProvider<SaftyCubit>(create: (context) => SaftyCubit()),
        BlocProvider<SettingsCubit>(create: (context) => SettingsCubit()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            darkTheme:
                state is DarkModeNight
                    ? AppTheme.darkTheme
                    : AppTheme.mainTheme,

            debugShowCheckedModeBanner: false,
            home: SplashView(),
          );
        },
      ),
    );
  }
}
