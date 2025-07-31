import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Icons, MaterialColor;

const Color appThemeColor = Color(0xFFE61125);
const inactiveGray = CupertinoColors.inactiveGray;
const Color softWhite = Color(0xFFF5F5F5);
const appicon = "assets/image/ResQMap_image.png";
const darkmode = Color.fromARGB(255, 20, 17, 17);


MaterialColor getDangerColor(String dangerLevel) {
  switch (dangerLevel.toLowerCase()) {
    case 'critical':
      return const MaterialColor(
        0xFFD32F2F, // Primary value
        {
          50: Color(0xFFFFEBEE),
          100: Color(0xFFFFCDD2),
          200: Color(0xFFEF9A9A),
          300: Color(0xFFE57373),
          400: Color(0xFFEF5350),
          500: Color(0xFFD32F2F),
          600: Color(0xFFC62828),
          700: Color(0xFFB71C1C),
          800: Color(0xFF8E0000),
          900: Color(0xFF5D0000),
        },
      );
    
    case 'moderate':
      return const MaterialColor(
        0xFFF57C00,
        {
          50: Color(0xFFFFF3E0),
          100: Color(0xFFFFE0B2),
          200: Color(0xFFFFCC80),
          300: Color(0xFFFFB74D),
          400: Color(0xFFFFA726),
          500: Color(0xFFF57C00),
          600: Color(0xFFFB8C00),
          700: Color(0xFFF57C00),
          800: Color(0xFFEF6C00),
          900: Color(0xFFE65100),
        },
      );
    
    case 'low':
      return const MaterialColor(
        0xFFFFA000,
        {
          50: Color(0xFFFFF8E1),
          100: Color(0xFFFFECB3),
          200: Color(0xFFFFE082),
          300: Color(0xFFFFD54F),
          400: Color(0xFFFFCA28),
          500: Color(0xFFFFA000),
          600: Color(0xFFFF8F00),
          700: Color(0xFFFF6F00),
          800: Color(0xFFFF5C00),
          900: Color(0xFFFF3D00),
        },
      );
    
    case 'safe' : 
      return const MaterialColor(
        0xFF388E3C,
        {
          50: Color(0xFFE8F5E9),
          100: Color(0xFFC8E6C9),
          200: Color(0xFFA5D6A7),
          300: Color(0xFF81C784),
          400: Color(0xFF66BB6A),
          500: Color(0xFF388E3C),
          600: Color(0xFF43A047),
          700: Color(0xFF388E3C),
          800: Color(0xFF2E7D32),
          900: Color(0xFF1B5E20),
        },
      );
    
    default:
      return Colors.blueGrey; // أكثر احترافية من الرمادي العادي
  }
}

String getDangerText(int dangerLevel) {
  switch (dangerLevel) {
    case 3:
      return "High";
    case 2:
      return "Medium";
    case 1:
      return "Low";
    case 0:
    default:
      return "None";
  }
}

enum TeamStatus { areaHandled, onSite, assistanceRequired, noTeamOnSite }

Icon getDangerIcon(int dangerLevel) {
  switch (dangerLevel) {
    case 3:
      return const Icon(
        Icons.warning,
        color: CupertinoColors.systemRed,
        size: 30,
      );
    case 2:
      return const Icon(
        Icons.report_problem,
        color: CupertinoColors.systemYellow,
        size: 30,
      );
    case 1:
      return const Icon(
        Icons.info,
        color: CupertinoColors.systemGreen,
        size: 30,
      );
    case 0:
    default:
      return const Icon(Icons.check_circle, color: Colors.green, size: 30);
  }
}
