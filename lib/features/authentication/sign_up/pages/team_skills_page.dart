import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:resq_map/features/authentication/sign_up/widgets/team_skills_view.dart';
import 'package:resq_map/features/home_page.dart';
import 'package:resq_map/features/profile/cubit/profile_cubit.dart';

class TeamSkillsPage extends StatefulWidget {
  const TeamSkillsPage({super.key});

  @override
  State<TeamSkillsPage> createState() => _TeamSkillsPageState();
}

class _TeamSkillsPageState extends State<TeamSkillsPage> {
  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).getTeamSkills();
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
        Widget? body = Center(child: CircularProgressIndicator());
        if (state is ProfileLoadedTeamSkills) {
          body = TeamsScreen(teams: state.skills);
        }
        if (state is ProfileError) {
          body = Center(child: Text("Something went wrong! Try Again Later"));
        }
        return Scaffold(body: body);
      },
    );
  }
}
