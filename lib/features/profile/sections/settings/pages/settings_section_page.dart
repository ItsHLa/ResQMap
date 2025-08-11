import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/services/actions.dart';
import 'package:resq_map/features/authentication/login/pages/login_page.dart';
import 'package:resq_map/features/profile/cubit/profile_cubit.dart';
import 'package:resq_map/features/profile/sections/settings/widgets/setting_section.dart';

class SettingsSectionPage extends StatefulWidget {
  const SettingsSectionPage({super.key});

  @override
  State<SettingsSectionPage> createState() => _SettingsSectionPageState();
}

class _SettingsSectionPageState extends State<SettingsSectionPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoading) {
          AppActions.showLoadingDialog(context);
        }
        if (state is DeactivateSuccess) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => LoginPage()));
        }
        if (state is ProfileError) {
          AppActions.showSnackBar(
            title: "Something Went Wrong! Please Try Again Later",
           context: context);
        }
      },
      child: SettingsSectionView(),
    );
  }
}
