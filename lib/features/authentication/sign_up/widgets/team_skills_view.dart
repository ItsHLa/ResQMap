import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/padding_constants.dart';
import 'package:resq_map/features/profile/model/team.dart';
import 'package:resq_map/features/profile/cubit/profile_cubit.dart';
import 'team_card.dart';

class TeamsScreen extends StatefulWidget {
  final List<EmergencyTeam> teams;

  const TeamsScreen({super.key, required this.teams});
  @override
  // ignore: library_private_types_in_public_api
  _TeamsScreenState createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  // Track selected teams
  Set<int> selectedIndices = Set<int>();

  void toggleSelection(int index) {
    setState(() {
      if (selectedIndices.contains(index)) {
        selectedIndices.remove(index);
      } else {
        selectedIndices.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PaddingConstants.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: PaddingConstants.appBarHeight),
          const Text(
            "Select your skills",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            "Let's build your emergency profile",
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          Expanded(
            child: ListView.builder(
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
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

          if (selectedIndices.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                List skills =
                    selectedIndices
                        .map((e) => widget.teams[e].teamName)
                        .toList();
                print(skills);
                BlocProvider.of<ProfileCubit>(
                  context,
                ).postTeamSkills({"skills": skills});
              },
              child: Text("Save"),
            ),
        ],
      ),
    );
  }
}
