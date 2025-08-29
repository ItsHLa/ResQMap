import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/features/profile/cubit/profile_cubit.dart';
import 'package:resq_map/features/profile/model/user.dart';
import 'package:resq_map/features/profile/sections/about/widget/image_picker.dart';
import 'package:resq_map/features/profile/widgets/info_fields.dart';
import 'package:resq_map/features/profile/sections/about/widget/skill_section.dart';

import '../../../../authentication/sign_up/pages/team_skills_page.dart';

class AboutPageView extends StatefulWidget {
  final User user;
  final TextEditingController email;
  final TextEditingController phoneNumber;
  final TextEditingController userName;

  const AboutPageView({
    super.key,
    required this.user,
    required this.email,
    required this.phoneNumber, required this.userName,
  });
  @override
  State<AboutPageView> createState() => _AboutPageViewState();
}

class _AboutPageViewState extends State<AboutPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('About', style: const TextStyle(
            color: softWhite,
            letterSpacing: 0.1,
            fontWeight: FontWeight.w300,
          ),),
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
                              print(widget.email.text);
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
                              print(widget.phoneNumber.text);
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
                              print(widget.userName.text);
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
              SkillSection(skill: widget.user.skills),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({required String title, bool showAdd  = false}) {
    return Row(
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
                      letterSpacing: 1,
                      fontWeight: FontWeight.w300,
                    ),
        ),
        Spacer(),
        if(showAdd)
           IconButton(onPressed: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeamSkillsPage(
              showBackArrow: true,
             ),));
           },
               iconSize: 35,
               icon: Icon(Icons.add))
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
