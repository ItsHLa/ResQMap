import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/services/actions.dart';
import 'package:resq_map/features/authentication/cubit/cubit/auth_cubit.dart';
import 'package:resq_map/features/authentication/login/widgets/login_view.dart';
import 'package:resq_map/features/home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          AppActions.showLoadingDialog(context);
        }
        if (state is AuthError) {
          Navigator.of(context).pop();
          AppActions.showSnackBar(title: state.msg, context: context);
        }
        if (state is AuthLogedIn) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MyHomePage()),
            (route) => false,
          );
        }
      },

      child: Scaffold(
        backgroundColor: Colors.white,
        body: LoginView()),
    );
  }
}
