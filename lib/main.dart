import 'package:flutter/material.dart';
import 'package:resq_map/core/constants.dart';
import 'package:resq_map/features/home_page.dart';


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
        inputDecorationTheme: const InputDecorationTheme(
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
        colorScheme: ColorScheme.fromSeed(seedColor: appThemeColor),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}
