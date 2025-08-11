import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/services/actions.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/core/constants/padding_constants.dart';
import 'package:resq_map/core/constants/text_styles.dart';
import 'package:resq_map/core/validators/password_validator.dart';
import 'package:resq_map/features/authentication/cubit/cubit/auth_cubit.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final changePasswordKey = GlobalKey<FormState>();
  List headers = ["Current Password", "New Password", "Re-type New Password"];
  List controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password", style: const TextStyle(
            color: softWhite,
            letterSpacing: 0.1,
            fontWeight: FontWeight.w300,
          ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(PaddingConstants.lg),
        child: ListView(
          children: [
            Text(
              "Your password must be at least 8 characters and should include a combination of numbers, letters and special characters (!@%\$)",
              style: TextStyles.textStyle18.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: PaddingConstants.md),
            Form(
              key: changePasswordKey,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: headers.length,
                itemBuilder:
                    (context, index) => Padding(
                      padding: const EdgeInsets.only(
                        left: PaddingConstants.sm,
                        right: PaddingConstants.sm,
                        bottom: PaddingConstants.md,
                      ),
                      child: TextFormField(
                        validator: PasswordValidator.validate,
                        controller: controllers[index],
                        decoration: InputDecoration(labelText: headers[index]),
                      ),
                    ),
              ),
            ),
            SizedBox(height: PaddingConstants.md),
            ElevatedButton(
              onPressed: () {
                if (changePasswordKey.currentState!.validate()) {
                  if (controllers[1].text == controllers[2].text) {
                    BlocProvider.of<AuthCubit>(context).changePassword({
                      "new_password": controllers[1].text,
                      "current_password": controllers[0].text,
                    });
                  } else {
                    AppActions.showSnackBar(
                      title:
                          "New Password and Re-Typed Password dose not match",
                      context: context,
                    );
                  }
                }
              },
              child: Text("Change Password"),
            ),
          ],
        ),
      ),
    );
  }
}
