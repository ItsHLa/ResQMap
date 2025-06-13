import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/padding_constants.dart';
import 'package:resq_map/core/validators/password_validator.dart';
import 'package:resq_map/features/authentication/cubit/cubit/auth_cubit.dart';
import 'package:resq_map/features/authentication/utils/back_header_widget.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({super.key, required this.userData});
  final Map<String, dynamic> userData;

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  GlobalKey<FormState> passwordKey = GlobalKey();
  bool obscureTextp1 = true;
  bool obscureTextp2 = true;
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(PaddingConstants.lg),
        child: Column(
          children: [
            BackHeader(),
            SizedBox(height: 40),
            Icon(Icons.password, size: 80, color: Colors.blue),
            SizedBox(height: 24),
            Text(
              'Create New Password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Your new password must be different from previous ones',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
      
            Form(
              key: passwordKey,
              child: Column(
                children: [
                  SizedBox(height: 32),
                  TextFormField(
                    validator: PasswordValidator.validate,
                    controller: _newPasswordController,
                    obscureText: obscureTextp1,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureTextp1 = !obscureTextp1;
                          });
                        },
                        icon: Icon(Icons.remove_red_eye_outlined),
                      ),
                      labelText: 'New Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: PasswordValidator.validate,
                    controller: _confirmPasswordController,
                    obscureText: obscureTextp2,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureTextp2 = !obscureTextp2;
                          });
                        },
                        icon: Icon(Icons.remove_red_eye_outlined),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (passwordKey.currentState!.validate()) {
                  widget.userData["confirm_password"] =
                      _confirmPasswordController.text.toString();
                  widget.userData["new_password"] =
                      _newPasswordController.text.toString();
                  print(widget.userData);
                  BlocProvider.of<AuthCubit>(
                    context,
                  ).resetPassword(widget.userData);
                }
              },
              child: Center(child: Text('Reset Password')),
            ),
          
          ],
        ),
      ),
    );
  }
}
