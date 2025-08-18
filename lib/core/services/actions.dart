import 'package:flutter/material.dart';
import 'package:resq_map/core/constants/constants.dart';

abstract class AppActions {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>  Center(child: CircularProgressIndicator(color: appThemeColor,)),
          );
  }
  static void showSnackBar({
    required String title,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
      ),
    );
  }

  static Future<void> moveToPage(Widget page, BuildContext context) async {
    await Future.microtask(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    });
  }

  static Future<void> handelDialog({
    required BuildContext context,
    required String title,
    required void Function()? onPressedConfirm,
    required void Function()? onPressedCancel,
  }) async {
    await Future.microtask(() {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              
              title: Text(title,
              textAlign: TextAlign.center,),
              content: Text("Are You Sure You want $title?"),
              actions: [
                TextButton(onPressed: onPressedConfirm, child: Text("Confirm")),
                TextButton(onPressed: onPressedCancel, child: Text("Cancel")),
              ],
            ),
      );
    });
  }
}
