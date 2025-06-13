import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:resq_map/core/constants.dart';
import 'package:resq_map/core/text_styles.dart';
import 'package:resq_map/features/alerts/alerts_cubit/alerts_cubit.dart';
import 'package:resq_map/features/authentication/pages/login_page.dart';
import 'package:resq_map/features/authentication/sign_up/pages/team_skills_page.dart';
import 'package:resq_map/features/authentication/sign_up/widgets/team_skills_view.dart';
import 'package:resq_map/features/authentication/utils/auth_service.dart';
import 'package:resq_map/features/authentication/cubit/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await AuthService.init();

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
      ],
      child: MaterialApp(
        theme: ThemeData(
          // checkboxTheme: CheckboxThemeData(
          //   fillColor: WidgetStateColor.resolveWith((states) {
          //     if (states.contains(WidgetState.selected)) {
          //       return appThemeColor;
          //     }
          //     return Colors.grey;
          //   }),
          // ),

        

          textSelectionTheme: TextSelectionThemeData(
            cursorColor: appThemeColor,
            selectionColor: Colors.red.shade200,
            selectionHandleColor: appThemeColor
          ),
        
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: appThemeColor
            )
          ),
          elevatedButtonTheme:ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              padding:  EdgeInsets.symmetric(vertical: 16.0),
              textStyle: TextStyle(color: softWhite),
              backgroundColor: appThemeColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
            )
          ) ,
         
          primaryColor: appThemeColor,
          iconTheme: IconThemeData(color: appThemeColor),
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusColor: appThemeColor,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: appThemeColor),
            ),
            prefixStyle: TextStyle(color: Colors.grey),
            prefixIconColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.focused)) {
                return appThemeColor;
              }
              return Colors.grey;
            }),
            labelStyle: WidgetStateTextStyle.resolveWith((states) {
              if (states.contains(WidgetState.focused)) {
                return TextStyles.textStyle18.copyWith(color: appThemeColor);
              }
              return TextStyles.textStyle18.copyWith(color: Colors.grey);
            }),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey),
            ),

            hintStyle: TextStyle(color: inactiveGray),
          ),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: appThemeColor,
          ),
          dividerTheme: const DividerThemeData(color: inactiveGray),
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: softWhite),
            backgroundColor: appThemeColor,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: LoginPage(),
        ),
      ),
    );
  }
}
