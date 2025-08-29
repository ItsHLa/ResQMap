import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/features/profile/model/team.dart';

class TeamCard extends StatelessWidget {
  final EmergencyTeam team;
  final bool isSelected;

  const TeamCard({required this.team, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12)
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(8),
        leading: isSelected ? Icon(Icons.check, color: Colors.green,) : Icon(Icons.emergency, color: appThemeColor,),
        selected: isSelected,
        selectedColor: Colors.green,
        title: Text(team.teamName, style:
         TextStyle(
         
          fontWeight: FontWeight.bold),),
        subtitle: Text(team.coreFunction, style: TextStyle(color: Colors.blueGrey),),
      ),
    );
    
  }
}
