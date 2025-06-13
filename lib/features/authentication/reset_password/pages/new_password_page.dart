import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/features/authentication/cubit/cubit/auth_cubit.dart';
import 'package:resq_map/features/authentication/reset_password/widgets/new_password.dart';
import 'package:resq_map/features/authentication/reset_password/widgets/reset_success.dart';

class NewPasswordPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const NewPasswordPage({super.key, required this.userData});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthPasswordReset) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => ResetSuccessScreen()));
        }
      },
      child: Scaffold(
        body: NewPasswordView(
          userData:widget.userData
        ),
      ),
    );
  }
}
