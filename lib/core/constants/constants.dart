import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, MaterialColor;
import 'package:resq_map/core/constants/colors_constants.dart';

const Color appThemeColor = Color(0xFFE61125);
const inactiveGray = CupertinoColors.inactiveGray;
const Color softWhite = Color(0xFFF5F5F5);
const appicon = "assets/image/ResQMap_image.png";
const darkmode = Color.fromARGB(255, 20, 17, 17);

MaterialColor getDangerColor(String dangerLevel) {
  switch (dangerLevel.toLowerCase()) {
    case 'critical':
      return ColorsConstants.DANGER_HIGH;
    case 'moderate':
      return ColorsConstants.DANGER_MODERATE;

    case 'low':
      return ColorsConstants.DANGER_LOW;

    default:
      return Colors.blueGrey; 
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

