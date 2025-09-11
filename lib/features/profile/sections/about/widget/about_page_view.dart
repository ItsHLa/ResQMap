import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/core/constants/text_styles.dart';
import 'package:resq_map/features/profile/cubit/profile_cubit.dart';
import 'package:resq_map/features/profile/model/user.dart';
import 'package:resq_map/features/profile/sections/about/pages/edit_team_skills.dart';
import 'package:resq_map/features/profile/sections/about/widget/image_picker.dart';
import 'package:resq_map/features/profile/widgets/info_fields.dart';
import 'package:resq_map/features/profile/sections/about/widget/skill_section.dart';

class AboutPageView extends StatefulWidget {
  final User user;
  final TextEditingController email;
  final TextEditingController phoneNumber;
  final TextEditingController userName;

  const AboutPageView({
    super.key,
    required this.user,
    required this.email,
    required this.phoneNumber,
    required this.userName,
  });
  @override
  State<AboutPageView> createState() => _AboutPageViewState();
}

class _AboutPageViewState extends State<AboutPageView> {
  List? skills;
  @override
  void initState() {
    skills = widget.user.skills;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'About',
          style: const TextStyle(
            color: softWhite,
            letterSpacing: 0.1,
            fontWeight: FontWeight.w300,
          ),
        ),
        elevation: 1,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImagePicker(image: widget.user.photos!),
              _buildSectionHeader(title: 'Contact Info'),
              _buildInfoItem(
                icon: Icons.email,
                type: "Email",
                text: widget.user.email,
                trailing: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder:
                          (context) => InfoFields(
                            labels: ["email"],
                            title: "email",
                            controller: [widget.email],
                            onSave: () {
                             
                              BlocProvider.of<ProfileCubit>(
                                context,
                              ).updateUserData({"email": widget.email.text});
                            },
                          ),
                    );
                  },
                  icon: Icon(Icons.edit_outlined),
                ),
              ),

              _buildInfoItem(
                icon: Icons.phone,
                type: "Phone Number",
                text: widget.user.phoneNumber,
                trailing: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder:
                          (context) => InfoFields(
                            labels: ["Phone Number"],
                            title: "Phone Number",
                            controller: [widget.phoneNumber],
                            onSave: () {
                            
                              BlocProvider.of<ProfileCubit>(
                                context,
                              ).updateUserData({
                                "phone_number": widget.phoneNumber.text,
                              });
                            },
                          ),
                    );
                  },
                  icon: Icon(Icons.edit_outlined),
                ),
              ),

              _buildInfoItem(
                icon: Icons.alternate_email,
                type: "Username",
                text: widget.user.userName,
                trailing: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder:
                          (context) => InfoFields(
                            labels: ["Username"],
                            title: "Username",
                            controller: [widget.userName],
                            onSave: () {
                             
                              BlocProvider.of<ProfileCubit>(
                                context,
                              ).updateUserData({
                                "username": widget.userName.text,
                              });
                            },
                          ),
                    );
                  },
                  icon: Icon(Icons.edit_outlined),
                ),
              ),

              _buildSectionHeader(title: 'Skills', showAdd: true),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileTeamSkillsPostSuccess) {
                    skills = state.skills;
                    
                  }
                  return SkillSection(skill: skills!);
               
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({required String title, bool showAdd = false}) {
    return Row(
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyles.textStyle16.copyWith(
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        if (showAdd)
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      (context) => EditTeamSkills(skills: widget.user.skills),
                ),
              );
            },
            iconSize: 35,
            icon: Icon(Icons.add , color: Colors.red[700],),
          ),
      ],
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    String? type,
    required String text,
    Widget? trailing,
  }) {
    return ListTile(
      
      trailing: trailing,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.red[700]),
      title: Text(text),
      subtitle: type != null ? Text(type) : null,
      minLeadingWidth: 24,
    );
  }
}
