import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/core_widgets/loading_widget.dart';
import 'package:resq_map/core/services/actions.dart';
import 'package:resq_map/core/core_widgets/appBar.dart';
import 'package:resq_map/core/constants/padding_constants.dart';
import 'package:resq_map/features/authentication/cubit/cubit/auth_cubit.dart';
import 'package:resq_map/features/authentication/login/pages/login_page.dart';
import 'package:resq_map/features/profile/cubit/profile_cubit.dart';
import 'package:resq_map/features/profile/sections/medical_record/pages/user_health_record_page.dart';
import 'package:resq_map/features/profile/sections/about/pages/about_page.dart';
import 'package:resq_map/features/profile/sections/settings/pages/settings_section_page.dart';
import 'package:resq_map/features/profile/widgets/profile_header.dart';
import 'package:resq_map/features/profile/widgets/switchers_settings.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).getProfile(); 
    super.initState();
  }


  

  List<String> titles = [
    "See your profile details",
    "Health & Medications",
    "Settings & Privacy",
    "Log Out",
  ];

  List<IconData> icons = [
    Icons.info_outline,
    Icons.medical_information,
    Icons.settings,
    Icons.logout,
  ];

  List<bool> backArrow = [false, true, true, false];

  List<Widget?>? navigateTo;
  String? url;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => current is GetProfileSuccess,
      listener: (context, state) {
        if (state is UpdateProfilePhotoSuccess) {
          setState(() {
            url = state.url;
          });
        }

        if (state is AuthLogedOut) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }

        if (state is GetProfileSuccess) {
          url = state.user.photos;

          navigateTo = [
            AboutPage(user: state.user),
            UserHealthRecordPage(record: state.med),
            SettingsSectionPage(),
          ];

         
        }
      },
      builder: (context, state) {
        print(state);

        return Scaffold(
          appBar: RAppBar(
            appBarHeight:
                state is! GetProfileSuccess ? null : kToolbarHeight * 3,
            title: "Profile",
            actions: [Icon(Icons.person_2_outlined, size: 30)],
            bottom:
                state is GetProfileSuccess
                    ? ProfileHeader(
                      firstName: state.user.firstName,
                      lastName: state.user.lastName,
                      username: state.user.userName,
                      url: url!,
                    )
                    : null,
          ),

          body:
              state is GetProfileSuccess
                  ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(height: PaddingConstants.sm),

                        // SETTINGS
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: titles.length - 1,
                          itemBuilder:
                              (context, index) => ListTile(
                                trailing:
                                    backArrow[index]
                                        ? Icon(Icons.arrow_forward_ios)
                                        : null,
                                leading: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    icons[index],
                                    color: Colors.red.shade500,
                                  ),
                                ),
                                onTap: () {
                                  if (navigateTo![index] != null) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder:
                                            (context) => navigateTo![index]!,
                                      ),
                                    );
                                  }
                                },
                                title: Text(titles[index]),
                              ),
                        ),

                        //SWITCHERS
                       SwitchersSettings(),
                        //LOGOUT
                        ListTile(
                          leading: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              icons[titles.length - 1],
                              color: Colors.red.shade500,
                            ),
                          ),
                          onTap: () {
                            AppActions.handelDialog(
                              context: context,
                              title: "Log Out",
                              onPressedConfirm: () {
                                BlocProvider.of<AuthCubit>(context).logOut();
                              },
                              onPressedCancel: () {
                                Navigator.of(context).pop();
                              },
                            );
                          },
                          title: Text(titles[titles.length - 1]),
                        ),
                      ],
                    ),
                  )
                  : state is ProfileLoading
                  ? LoadingAnimation()
                  : Container(color: Colors.red),
        );
      },
    );
  }
}
