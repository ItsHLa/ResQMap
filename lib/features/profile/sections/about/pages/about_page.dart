import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/services/actions.dart';
import 'package:resq_map/features/profile/cubit/profile_cubit.dart';
import 'package:resq_map/features/profile/model/user.dart';
import 'package:resq_map/features/profile/sections/about/widget/about_page_view.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key, required this.user});
  final User user;

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController userName = TextEditingController();
  late User copyUser;
  @override
  void initState() {
    copyUser = widget.user;
    email.text = widget.user.email;
    phoneNumber.text = widget.user.phoneNumber;
    userName.text = widget.user.userName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          AppActions.showSnackBar(title: state.msg, context: context);
        }
        if (state is UpdateUserInfoProfileSuccess) {
          setState(() {
            copyUser.email = email.text;
            copyUser.phoneNumber = phoneNumber.text;
            copyUser.userName = userName.text;
          });
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
        if (state is ProfileLoading) {
          AppActions.showLoadingDialog(context);
        }
        if (state is UpdateProfilePhotoSuccess) {
          Navigator.of(context).pop();
          setState(() {
            copyUser.photos = state.url;
          });
          AppActions.showSnackBar(title: state.msg, context: context);
        }
      },
      child: AboutPageView(
        userName: userName,
        phoneNumber: phoneNumber,
        email: email,
        user: widget.user,
      ),
    );
  }
}
