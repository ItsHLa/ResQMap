import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/features/authentication/cubit/cubit/auth_cubit.dart';
import 'package:resq_map/features/authentication/utils/otp_verify_view.dart';
import 'package:resq_map/features/authentication/sign_up/pages/team_skills_page.dart';

class EmailVerifyPage extends StatefulWidget {
  final Map<String, dynamic> data;
  final String purpose;
  const EmailVerifyPage({super.key, required this.data, required this.purpose});

  @override
  State<EmailVerifyPage> createState() => _EmailVerifyPageState();
}

class _EmailVerifyPageState extends State<EmailVerifyPage> {
  Map<String, dynamic> userData = {};
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignedUp) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => TeamSkillsPage()),
          );
        }
        if (state is AuthEmailVerify) {
          if (mounted) {
            Navigator.of(context).pop();
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('New OTP sent successfully!')),
          );
        }
        if (state is AuthError) {
          if (mounted) {
            Navigator.of(context).pop();
          }
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.msg)));
        }
      },
      child: Scaffold(
        body: OtpVerificationPage(
          userData: widget.data,
          purpose: widget.purpose,
        ),
      ),
    );
  }
}
