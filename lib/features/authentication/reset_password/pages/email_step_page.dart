import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/features/authentication/cubit/cubit/auth_cubit.dart';
import 'package:resq_map/features/authentication/reset_password/widgets/email_step.dart';
import 'package:resq_map/features/authentication/utils/email_verify_page.dart';

class EmailStepPage extends StatefulWidget {
  const EmailStepPage({super.key});

  @override
  State<EmailStepPage> createState() => _EmailStepPageState();
}

class _EmailStepPageState extends State<EmailStepPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthEmailVerify) {
          if (mounted) {
            // Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmailVerifyPage(
              purpose: "reset",
              data: state.data!,
               

            ),));
          }
        }
      },
      child: EmailStepView(),
    );
  }
}
