
import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.title,
    
    this.childern,  this.about,
  });
  final String title;
  final String? about;

  final List<Widget>? childern;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style:TextStyle(
                  letterSpacing: 1,
                  fontWeight: FontWeight.w300,
                )),
        if (childern != null) ...childern!,
      ],
    );
  }
}
