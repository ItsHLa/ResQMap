import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/features/profile/cubit/profile_cubit.dart';
import 'package:resq_map/features/profile/sections/settings/pages/change_password_page.dart' show ChangePasswordPage;
import 'package:resq_map/features/profile/sections/settings/pages/login_activity.dart';
import 'package:resq_map/features/profile/sections/settings/widgets/setting_item.dart';

class SettingsSectionView extends StatefulWidget {
  const SettingsSectionView({super.key});

  @override
  State<SettingsSectionView> createState() => _SettingsSectionViewState();
}

class _SettingsSectionViewState extends State<SettingsSectionView> {
  List headers = [
    'Security & Login',
    // 'Accessibility & Display',
    'Account Action',
  ];

  List<List> actions = [
    [
      {
        "arrow": true,
        "title": Text("Change Password"),
        "onTap": (context) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => ChangePasswordPage()));
        },
      },
      {
        "arrow": true,
        "title": Text("Login Activity"),
        "onTap": (context) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => LoginActivityPage()));
        },
      },
    ],
    // [
    //   {"arrow": false, "title": Text("Dark Mode"), "onTap": (context) {}},
    // ],
    [
      {
        "arrow": false,
        "title": Text("Deactivate Account"),
        "onTap": (context) {
          BlocProvider.of<ProfileCubit>(context).deactivateAccount();
        },
      },
      {
        "arrow": false,
        "title": Text("Delete Account", style: TextStyle(color: Colors.red)),
        "onTap": (context) {
          BlocProvider.of<ProfileCubit>(context).deleteAccount();
        },
      },
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: const TextStyle(
            color: softWhite,
            letterSpacing: 0.1,
            fontWeight: FontWeight.w300,
          ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: headers.length,
          itemBuilder:
              (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: SettingItem(
                  title: headers[index],
                  childern:
                      actions[index]
                          .map(
                            (action) => ListTile(
                              trailing:
                                  action["arrow"]
                                      ? Icon(Icons.arrow_forward_ios)
                                      : null,
                              onTap: () {
                                action["onTap"](context);
                              },
                              title: action["title"],
                            ),
                          )
                          .toList(),
                ),
              ),
        ),
      ),
    );
  }
}
