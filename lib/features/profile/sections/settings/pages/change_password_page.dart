import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/services/actions.dart';
import 'package:resq_map/features/authentication/cubit/cubit/auth_cubit.dart';
import 'package:resq_map/features/profile/sections/settings/widgets/change_password_view.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          AppActions.showLoadingDialog(context);
        }
        if (state is AuthChangePassword) {
          Navigator.of(context).pop();
          AppActions.showSnackBar(
            title: "Password Changed Succssfully!",
            context: context,
          );
        }
        if (state is AuthError) {
          Navigator.of(context).pop();
          AppActions.showSnackBar(title: state.msg, context: context);
        }
      },
      child: ChangePasswordView(),
    );
  }
}
