import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/core_widgets/loading_widget.dart';
import 'package:resq_map/core/core_widgets/state_widget.dart';
import 'package:resq_map/core/services/actions.dart';
import 'package:resq_map/features/authentication/sign_up/widgets/team_skills_view.dart';
import 'package:resq_map/features/profile/cubit/profile_cubit.dart';

class EditTeamSkills extends StatefulWidget {
  const EditTeamSkills({super.key, this.skills});
  final List? skills;

  @override
  State<EditTeamSkills> createState() => _EditTeamSkillsState();
}

class _EditTeamSkillsState extends State<EditTeamSkills> {
  List? copySkills;
  Future<void> _refreshData() async {
    await BlocProvider.of<ProfileCubit>(context).getTeamSkills();
  }

  @override
  void initState() {
    copySkills = widget.skills;
    _refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) {
        return current is ProfileLoading ||
            current is ProfileLoadedTeamSkills ||
            current is ProfileLoadingTeamSkills||
            current is ProfileError;
      },
      listener: (context, state) {
        if (state is TeamSkillsLoading) {
          AppActions.showLoadingDialog(context);
        }
        if (state is ProfileTeamSkillsPostSuccess) {
          if (state.edit) {
            Navigator.of(context).pop();
            Navigator.of(context).pop(state.skills);
            AppActions.showSnackBar(title: "Skills Updated!", context: context);
          }
        }
        if (state is ProfileError) {
          Navigator.of(context).pop();
          AppActions.showSnackBar(title: state.msg, context: context);
        }
        print(state);
      },
      builder: (context, state) {
        Widget? body = LoadingAnimation();
        if (state is ProfileLoadedTeamSkills) {
          body = TeamsScreen(
            skills: copySkills,
            showBackArrow: true,
            edit: true,
            teams: state.skills,
          );
        }
        if (state is ProfileError) {
          body = MyStateWidget(
            refreshData: _refreshData,
            title: "Failed To Load",
            iconData: Icons.error,
          );
        }
        return Scaffold(body: body);
      },
    );
  }
}
