import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resq_map/features/earthquake/quacke_alerts/models/team_model.dart';

class TeamMemberCard extends StatelessWidget {
  final TeamModel member;

  const TeamMemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Header with user info
            Row(
              children: [
                // Profile image with online status
                Stack(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // color: Colors.red,

                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(member.user.photos!),
                        ),
                      ),
                    ),
                    if (member.user.isOnline)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),

                // User name and info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${member.user.firstName} ${member.user.lastName}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '@${member.user.userName}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 2),
                      if (!member.user.isOnline)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      
                      const SizedBox(height: 2),
                      Text(
                        member.user.lastSeen ?? 'Unknown',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
              
                      
                    ],
                  ),
                ),

              
              ],
            ),

            const SizedBox(height: 16),
            // Contact Info
            ListTile(
              leading: Icon(Icons.phone, color: Colors.red,),
              title: Text("CONTACT INFO",style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey[600],
                  letterSpacing: 1,
                ),),
              subtitle: Text(
                        member.user.phoneNumber,
                        style: TextStyle(fontSize: 14),
                      ),
            ),
           const SizedBox(height: 16),

// DATE
ListTile(
  leading: Icon(Icons.date_range_outlined, color: Colors.red,),
  subtitle: Text(
                        _formatDate(member.joinAt),
                        style: const TextStyle(
                          fontSize: 14,
                          
                        ),
                      ),
  title:Text(
                        'JOINED',
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 1,
                          color: Colors.blueGrey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
),
       const SizedBox(height: 16),    

            // Roles section
            if (member.role != null && member.role!.isNotEmpty) ...[

              ExpansionTile(
                shape: RoundedRectangleBorder(),
  leading: Icon(Icons.emergency_outlined, color: Colors.red),
  title: Text(
    'ROLES',
    style: TextStyle(
      fontSize: 12,
      
      fontWeight: FontWeight.w600,
      color: Colors.blueGrey[600],
      letterSpacing: 1,
    ),
  ),
  
  children: [
    Container(
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 8, 
        runSpacing: 8, 
        children: member.role!
            .map((role) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.red.withOpacity(0.3), width: 1.5),
                    color: Colors.red.withOpacity(0.1),
                  ),
                  child: Text(
                    role.toString().replaceAll("Team", ""),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ))
            .toList(),
      ),
    ),
  ],
)
              
             
              
            ],
 
          ],
        ),
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Unknown';

    try {
      final dateTime = DateTime.parse(dateString);
      final formatter = DateFormat('MMM dd, yyyy • HH:mm');
      return formatter.format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }
}
