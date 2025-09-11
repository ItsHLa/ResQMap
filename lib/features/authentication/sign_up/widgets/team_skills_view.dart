// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:resq_map/core/constants/constants.dart';
// import 'package:resq_map/core/constants/padding_constants.dart';
// import 'package:resq_map/features/profile/model/team.dart';
// import 'package:resq_map/features/profile/cubit/profile_cubit.dart';
// import 'team_card.dart';

// class TeamsScreen extends StatefulWidget {
//   final List<EmergencyTeam> teams;
//   final bool showBackArrow;
//   final List? skills;
//   const TeamsScreen({
//     super.key,
//     required this.teams,
//     this.skills,
//     this.showBackArrow = false,
//   });
//   @override
//   // ignore: library_private_types_in_public_api
//   _TeamsScreenState createState() => _TeamsScreenState();
// }

// class _TeamsScreenState extends State<TeamsScreen> {
//   List copyskills = [];

//   @override
//   initState() {
//     if (widget.skills != null) {
//       copyskills.addAll(widget.skills!);
//     }

//     super.initState();
//   }

//   // Track selected teams
//   Set<int> selectedIndices = Set<int>();

//   void toggleSelection(int index) {
//     setState(() {
//       if (selectedIndices.contains(index)) {
//         selectedIndices.remove(index);
//       } else {
//         selectedIndices.add(index);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: appThemeColor,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: PaddingConstants.lg),
//           if (widget.showBackArrow)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   icon: Icon(Icons.arrow_back, color: softWhite),
//                 ),
//                 Spacer(),
//               ],
//             ),
//           Padding(
//             padding: const EdgeInsets.only(left: 16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Select Your Skills",
//                   style: TextStyle(
//                     color: softWhite,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   "Let's build your emergency profile",
//                   style: TextStyle(color: softWhite, fontSize: 16),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 16),
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Theme.of(context).scaffoldBackgroundColor,
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(24),
//                 ),
//               ),
//               child: ListView.builder(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 16,
//                 ),
//                 itemCount: widget.teams.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () => toggleSelection(index),
//                     child: TeamCard(
//                       team: widget.teams[index],
//                       isSelected: selectedIndices.contains(index),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),

//           if (selectedIndices.isNotEmpty)
//             ElevatedButton(
//               onPressed: () {
//                 List<String> selectedSkills =
//                     selectedIndices
//                         .map((e) => widget.teams[e].teamName)
//                         .toList();
//                 print(copyskills);
//                 copyskills.addAll(selectedSkills);
//                 print(copyskills);

//                 BlocProvider.of<ProfileCubit>(
//                   context,
//                 ).postTeamSkills(copyskills);
//               },
//               child: Text("Save"),
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/core/constants/padding_constants.dart';
import 'package:resq_map/features/profile/model/team.dart';
import 'package:resq_map/features/profile/cubit/profile_cubit.dart';
import 'team_card.dart';

class TeamsScreen extends StatefulWidget {
  final List<EmergencyTeam> teams;
  final bool showBackArrow;
  final List? skills;
  final bool edit;
  const TeamsScreen({
    super.key,
    required this.teams,
    this.skills,
    this.showBackArrow = false, this.edit = false,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TeamsScreenState createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  late Set<String> selectedSkills;
  late Set<int> selectedIndices;

  @override
  void initState() {
    super.initState();

    // Initialize selectedSkills from widget.skills or empty set
    selectedSkills =
        widget.skills != null
            ? Set<String>.from(widget.skills!.map((skill) => skill.toString()))
            : <String>{};

    // Initialize selectedIndices based on initial skills
    selectedIndices = _getInitialSelectedIndices();
  }

  Set<int> _getInitialSelectedIndices() {
    final indices = <int>{};
    for (int i = 0; i < widget.teams.length; i++) {
      if (selectedSkills.contains(widget.teams[i].teamName)) {
        indices.add(i);
      }
    }
    return indices;
  }

  void toggleSelection(int index) {
    setState(() {
      final teamName = widget.teams[index].teamName;

      if (selectedIndices.contains(index)) {
        selectedIndices.remove(index);
        selectedSkills.remove(teamName);
      } else {
        selectedIndices.add(index);
        selectedSkills.add(teamName);
      }
    });
  }

  void _saveSkills() {
    List<String> skillsList = selectedSkills.toList();
    print("selected");
    print(skillsList);
    BlocProvider.of<ProfileCubit>(
      context,
    ).postTeamSkills(copyskills: skillsList, edit: widget.edit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appThemeColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: PaddingConstants.lg),

          // Back button and header
          if (widget.showBackArrow)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back, color: softWhite),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          if (!widget.showBackArrow)
            SizedBox(height: 17,),
            
          

          // Header text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Your Skills",
                  style: TextStyle(
                    color: softWhite,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Let's build your emergency profile",
                  style: TextStyle(color: softWhite, fontSize: 16),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Teams list
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      itemCount: widget.teams.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => toggleSelection(index),
                          child: TeamCard(
                            team: widget.teams[index],
                            isSelected: selectedIndices.contains(index),
                          ),
                        );
                      },
                    ),
                  ),

                  // Save button
                  if (selectedSkills.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: _saveSkills,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appThemeColor,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Save Skills",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
