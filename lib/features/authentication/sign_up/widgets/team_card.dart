import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resq_map/features/authentication/model/team_skill_model/team.dart';

class TeamCard extends StatelessWidget {
  final EmergencyTeam team;
  final bool isSelected;

  const TeamCard({
    required this.team,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected
            ? BorderSide(color: Colors.red[700]!, width: 2)
            : BorderSide.none,
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    team.teamName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.red[700] : Colors.black,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check_circle, color: Colors.red[700]),
              ],
            ),
            SizedBox(height: 8),
            Text(
              team.coreFunction,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}