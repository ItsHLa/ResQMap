import 'package:flutter/material.dart';
import 'package:resq_map/core/constants/colors_constants.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/core/constants/text_styles.dart';

class AppTheme {
  static ThemeData get mainTheme => ThemeData(
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return appThemeColor.withOpacity(0.8);
        }
        if (states.contains(WidgetState.dragged)) {
          return appThemeColor.withOpacity(0.8);
        }
        if (states.contains(WidgetState.focused)) {
          return appThemeColor.withOpacity(0.8);
        }
        if (states.contains(WidgetState.hovered)) {
          return appThemeColor.withOpacity(0.8);
        }
        if (states.contains(WidgetState.pressed)) {
          return appThemeColor.withOpacity(0.8);
        }
        if (states.contains(WidgetState.scrolledUnder)) {
          return appThemeColor.withOpacity(0.8);
        }

        return Colors.grey;
      }),
      trackColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return appThemeColor.withOpacity(0.3);
        }
        if (states.contains(WidgetState.dragged)) {
          return appThemeColor.withOpacity(0.3);
        }
        if (states.contains(WidgetState.focused)) {
          return appThemeColor.withOpacity(0.3);
        }
        if (states.contains(WidgetState.hovered)) {
          return appThemeColor.withOpacity(0.3);
        }
        if (states.contains(WidgetState.pressed)) {
          return appThemeColor.withOpacity(0.3);
        }
        if (states.contains(WidgetState.scrolledUnder)) {
          return appThemeColor.withOpacity(0.3);
        }

        return Colors.grey.withOpacity(0.3);
      }),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: appThemeColor,
      unselectedItemColor: Colors.blueGrey,
      selectedIconTheme: IconThemeData(color: appThemeColor),
      selectedLabelStyle: TextStyle(letterSpacing: 0.1, color: appThemeColor),
    ),

    visualDensity: VisualDensity.adaptivePlatformDensity,

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: appThemeColor,
      selectionColor: Colors.red.shade200,
      selectionHandleColor: appThemeColor,
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: appThemeColor),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        textStyle: const TextStyle(color: softWhite),
        backgroundColor: appThemeColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        textStyle: const TextStyle(color: softWhite),
        foregroundColor: Colors.red,
        side: BorderSide(color: appThemeColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),

    primaryColor: appThemeColor,

    iconTheme: const IconThemeData(color: appThemeColor),

    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusColor: appThemeColor,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: appThemeColor),
      ),
      prefixStyle: const TextStyle(color: Colors.grey),
      prefixIconColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.focused)) {
          return appThemeColor;
        }
        return Colors.grey;
      }),
      labelStyle: MaterialStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyles.textStyle18.copyWith(color: appThemeColor.withOpacity(0.8));
        }
        if (states.contains(WidgetState.dragged)) {
          return TextStyles.textStyle18.copyWith(color: appThemeColor.withOpacity(0.8));
        }
        if (states.contains(WidgetState.focused)) {
          return TextStyles.textStyle18.copyWith(color: appThemeColor.withOpacity(0.8));
        }
        if (states.contains(WidgetState.hovered)) {
          return TextStyles.textStyle18.copyWith(color: appThemeColor.withOpacity(0.8));
        }
        if (states.contains(WidgetState.pressed)) {
          return TextStyles.textStyle18.copyWith(color: appThemeColor.withOpacity(0.8));
        }
        if (states.contains(WidgetState.scrolledUnder)) {
          return TextStyles.textStyle18.copyWith(color: appThemeColor.withOpacity(0.8));
        }

        return TextStyles.textStyle18.copyWith(color: Colors.grey);
      }),
      helperStyle: MaterialStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyles.textStyle18.copyWith(color: appThemeColor.withOpacity(0.8));
        }
        if (states.contains(WidgetState.dragged)) {
          return TextStyles.textStyle18.copyWith(color: appThemeColor.withOpacity(0.8));
        }
        if (states.contains(WidgetState.focused)) {
          return TextStyles.textStyle18.copyWith(color: appThemeColor.withOpacity(0.8));
        }
        if (states.contains(WidgetState.hovered)) {
          return TextStyles.textStyle18.copyWith(color: appThemeColor.withOpacity(0.8));
        }
        if (states.contains(WidgetState.pressed)) {
          return TextStyles.textStyle18.copyWith(color: appThemeColor.withOpacity(0.8));
        }
        if (states.contains(WidgetState.scrolledUnder)) {
          return TextStyles.textStyle18.copyWith(color: appThemeColor.withOpacity(0.8));
        }

        return TextStyles.textStyle18.copyWith(color: Colors.grey);
      }),
      
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      hintStyle: MaterialStateTextStyle.resolveWith((states) {
        if (states.contains(MaterialState.focused)) {
          return TextStyles.textStyle18.copyWith(color: appThemeColor);
        }
        return TextStyles.textStyle18.copyWith(color: Colors.grey);
      }),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: appThemeColor,
    ),

    dividerTheme: const DividerThemeData(color: inactiveGray),

    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyles.textStyle18.copyWith(
        fontSize: 20,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w300,
        color: ColorsConstants.SOFT_WHITE,
      ),
      iconTheme: IconThemeData(color: softWhite),
      backgroundColor: appThemeColor,
    ),
  );

  static ThemeData get darkTheme => ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: mainTheme.primaryColor,
    switchTheme: mainTheme.switchTheme,
    scaffoldBackgroundColor: ColorsConstants.DARK_MODE,
    textButtonTheme: mainTheme.textButtonTheme,
    inputDecorationTheme: mainTheme.inputDecorationTheme,
    appBarTheme: mainTheme.appBarTheme,
    bottomNavigationBarTheme: mainTheme.bottomNavigationBarTheme,
    bottomSheetTheme: mainTheme.bottomSheetTheme,
    textSelectionTheme: mainTheme.textSelectionTheme,
    dividerTheme: mainTheme.dividerTheme,
    indicatorColor: mainTheme.indicatorColor,
    iconButtonTheme: mainTheme.iconButtonTheme,
    outlinedButtonTheme: mainTheme.outlinedButtonTheme,
    elevatedButtonTheme: mainTheme.elevatedButtonTheme,
    
  );
}
