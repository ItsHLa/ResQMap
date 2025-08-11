import 'package:flutter/material.dart';
import 'package:resq_map/core/constants/constants.dart';

class SkillSection extends StatefulWidget {
  const SkillSection({super.key, required this.skill});
  final List skill;

  @override
  State<SkillSection> createState() => _SkillSectionState();
}

class _SkillSectionState extends State<SkillSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.skill.map((s) {
        return ListTile(
          iconColor: appThemeColor,
          leading:  Icon(Icons.emergency),
          title:   Text(s,),
         
        );
      }).toList(),
    );
    
  
  
  }
}

