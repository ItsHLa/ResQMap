import 'package:flutter/material.dart';
import 'package:resq_map/core/core_widgets/state_widget.dart';
import 'package:resq_map/features/earthquake/quacke_alerts/models/alert_model.dart';
import 'package:resq_map/features/earthquake/quacke_alerts/widgets/team_card_item.dart';

import '../models/team_model.dart';

class TeamPageView extends StatefulWidget {
  const TeamPageView({super.key, required this.alert});
  final Alert alert;

  @override
  State<TeamPageView> createState() => _TeamPageViewState();
}

class _TeamPageViewState extends State<TeamPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Squad List")),
      body:widget.alert.teams.isEmpty?MyStateWidget(
        title: "No member joined till now", 
        iconData: Icons.no_accounts_outlined): ListView.builder(
        itemCount: widget.alert.teams.length,
        itemBuilder: (context, index) {
          TeamModel member = widget.alert.teams[index];
          return TeamMemberCard(
           member: member,
          );
        },
      ),
    );
  }
}
