import 'package:flutter/material.dart';
import 'package:resq_map/core/constants.dart';
import 'package:resq_map/core/text_styles.dart';
import 'package:resq_map/features/authentication/pages/login_view.dart';
import 'package:resq_map/features/authentication/pages/sign_up_view.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: appThemeColor,
        iconTheme: IconThemeData(
          color: appThemeColor,),
        inputDecorationTheme:  InputDecorationTheme(
         
          enabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey)
          ) ,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey)
          ) ,
          focusColor: appThemeColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color:appThemeColor)
          ) ,
          prefixStyle: TextStyle(color: Colors.grey),
          prefixIconColor:WidgetStateColor.resolveWith(
            (states) {
              if(states.contains(WidgetState.focused)){
                return appThemeColor;
              }
              return Colors.grey; 
            },),
            labelStyle:WidgetStateTextStyle.resolveWith(
            (states) {
              if(states.contains(WidgetState.focused)){
                return TextStyles.textStyle18.copyWith(color:appThemeColor);
              }
              return TextStyles.textStyle18.copyWith(color: Colors.grey); 
            },),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey)
          ),
  
            hintStyle: TextStyle(color: inactiveGray)),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: appThemeColor),
        dividerTheme: const DividerThemeData(color: inactiveGray),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: softWhite,
          ),
          backgroundColor: appThemeColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home:  LoginView(),
    );
  }
}
