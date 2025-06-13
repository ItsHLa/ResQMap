import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/padding_constants.dart';
import 'package:resq_map/core/urls.dart';
import 'package:resq_map/features/authentication/cubit/cubit/auth_cubit.dart';
import 'package:resq_map/features/authentication/utils/back_header_widget.dart';

class EmailStepView extends StatefulWidget {
  const EmailStepView({
    super.key,
    this.navigateTo,
  });
  final void Function()? navigateTo;

  @override
  State<EmailStepView> createState() => _EmailStepViewState();
}

class _EmailStepViewState extends State<EmailStepView> {
  GlobalKey<FormState> emailKey = GlobalKey();
  final _emailController = TextEditingController();
  void _requestOTP() {
    BlocProvider.of<AuthCubit>(context).generateOTP(
      requestResetUrl,
      {"email": _emailController.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(PaddingConstants.lg),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BackHeader(),
               SizedBox(height: PaddingConstants.spaceBtwSections),
              const Icon(Icons.lock_reset, size: 80, color: Colors.blue),
              const SizedBox(height:PaddingConstants.md),
              const Text(
                'Reset Your Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
               SizedBox(height : PaddingConstants.md),
              const Text(
                'Enter your email to receive a verification code',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: PaddingConstants.xl),
              Form(
                key: emailKey,
                child: TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return "Email can't be empty";
                    } else if (value.isEmpty) {
                      return "Email can't be empty";
                    } else if (!value.contains('@')) {
                      return "Invalid Email";
                    } else {
                      return null;
                    }
                  },
                  controller:_emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: const Icon(Icons.email),
          
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (emailKey.currentState!.validate()) {
                    print(_emailController.text);
                    _requestOTP();
                  }
                },
          
                child: const Text('Send Verification Code'),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
