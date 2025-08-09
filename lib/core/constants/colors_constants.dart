import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorsConstants {
  static Color SOFT_WHITE = Color(0xFFF5F5F5);
  static Color DARK_MODE = Color.fromARGB(255, 20, 17, 17);
  static Color APP_THEME_COLOR = Color(0xFFE61125);

  static MaterialColor DANGER_HIGH = const MaterialColor(
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
  
  static MaterialColor DANGER_MODERATE = const MaterialColor(0xFFF57C00, {
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
      });

   static MaterialColor DANGER_LOW =const MaterialColor(0xFF388E3C, {
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
      });
}
