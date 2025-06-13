import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/features/authentication/cubit/cubit/auth_cubit.dart';
import 'package:resq_map/features/authentication/sign_up/widgets/team_skills_view.dart';
import 'package:resq_map/features/home_page.dart';

class TeamSkillsPage extends StatefulWidget {
  const TeamSkillsPage({super.key});

  @override
  State<TeamSkillsPage> createState() => _TeamSkillsPageState();
}

class _TeamSkillsPageState extends State<TeamSkillsPage> {
  @override
  void initState() {
    BlocProvider.of<AuthCubit>(context).getTeamSkills();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadedTeamSkills) {
          Navigator.of(context).pop();
        }
        if (state is AuthTeamSkillsPostSuccess) {
          Navigator.of(
            context,
          ).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
        }
      },
      builder: (context, state) {
        Widget body;
        if (state is AuthLoadedTeamSkills) {
          body = TeamsScreen(teams: state.skills);
        } else if (state is AuthError) {
          body = Center(child: Text("Something went wrong"));
        } else {
          body = Container();
        }
        return Scaffold(body: body);
      },
    );
  }
}
