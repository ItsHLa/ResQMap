import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/features/authentication/cubit/cubit/auth_cubit.dart';
import 'package:resq_map/features/authentication/otp/pages/email_verify_page.dart';
import 'package:resq_map/features/authentication/sign_up/widgets/sign_up_view.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthEmailVerify) {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EmailVerifyPage(
                purpose: "verify",
                data: state.data as Map<String,dynamic>,
              ))
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SignUpView(),
        ),
      ),
    );
  }
}
