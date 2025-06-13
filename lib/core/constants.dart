import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Icons, MaterialColor;

const Color appThemeColor = Color(0xFFE61125);
const inactiveGray = CupertinoColors.inactiveGray;
const Color softWhite = Color(0xFFF5F5F5);
const appicon = "assets/image/ResQMap_image.png";
const baseUrlHttps ='https://resqserver.up.railway.app';
const baseUrlWss ='wss://resqserver.up.railway.app';
const alertsUrl ='$baseUrlWss/ws/alerts/emergency/';
const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUwMDc1NjU0LCJpYXQiOjE3NDg3Nzk2NTQsImp0aSI6ImU5Mzk5Y2EyMTkyNTQxMzE4ZGY3NTJkNTE1MjcxZTNlIiwidXNlcl9pZCI6Mn0.I7lUdLwIqDsGYD7rT_QKJSQwDY8aOsWkFWXUa4V4nB4';
const mapUrl = "$baseUrlHttps/maps/path/route/";
MaterialColor getDangerColor(String dangerLevel) {
  switch (dangerLevel.toLowerCase()) {
    case 'critical':
      return Colors.red;
    case 'moderate':
      return Colors.yellow;
    case 'low':
      return Colors.green;
    case 'safe':
    default:
      return Colors.grey;
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

enum TeamStatus {
  areaHandled,
  onSite,
  assistanceRequired,
  noTeamOnSite,
}

Icon getDangerIcon(int dangerLevel) {
  switch (dangerLevel) {
    case 3:
      return const Icon(Icons.warning, color: CupertinoColors.systemRed, size: 30);
    case 2:
      return const Icon(Icons.report_problem, color: CupertinoColors.systemYellow, size: 30);
    case 1:
      return const Icon(Icons.info, color: CupertinoColors.systemGreen, size: 30);
    case 0:
    default:
      return const Icon(Icons.check_circle, color: Colors.green, size: 30);
  }}