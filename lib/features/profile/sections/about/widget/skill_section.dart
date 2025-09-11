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
    return (widget.skill.isNotEmpty)  ?  Wrap(
      spacing: 8,
      runSpacing: 4,

      children: widget.skill.map((s) {
        return Chip(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16)
          ),
          avatar:  CircleAvatar(
            backgroundColor:  appThemeColor,
            child: Icon(Icons.emergency_outlined,color:softWhite )),
          label:   Text(s.toString().replaceAll("Team" , ""),),
         
        );
      }).toList()
    ): Row(
      children: [
        Icon(Icons.emergency, color: appThemeColor,),
        SizedBox(width: 8,),
        Text("There is no skills to show" , style: TextStyle(color: Colors.blueGrey),)
      ],
    );
    
  
  
  }
}

