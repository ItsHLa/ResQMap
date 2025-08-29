import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:resq_map/core/core_widgets/loading_widget.dart';
import 'package:resq_map/core/core_widgets/state_widget.dart';

import 'package:resq_map/features/authentication/sign_up/widgets/team_skills_view.dart';
import 'package:resq_map/features/home/home_page.dart';
import 'package:resq_map/features/profile/cubit/profile_cubit.dart';

class TeamSkillsPage extends StatefulWidget {
  const TeamSkillsPage({super.key,  this.showBackArrow = false});
  final bool showBackArrow;
  @override
  State<TeamSkillsPage> createState() => _TeamSkillsPageState();
}

class _TeamSkillsPageState extends State<TeamSkillsPage> {
  Future<void> _refreshData() async {
    await BlocProvider.of<ProfileCubit>(context).getTeamSkills();
  }
  @override
  void initState() {
    _refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        print(state);

        if (state is ProfileTeamSkillsPostSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        }
      },
      builder: (context, state) {
        Widget? body = LoadingAnimation();
        if (state is ProfileLoadedTeamSkills) {
          body = TeamsScreen(
            showBackArrow: widget.showBackArrow,
            teams: state.skills);
        }
        if (state is ProfileError) {
          body = MyStateWidget(
            refreshData: _refreshData,
            title: "Faild To Load", iconData: Icons.error);
        }
        return Scaffold(
          body: body);
      },
    );
  }
}
