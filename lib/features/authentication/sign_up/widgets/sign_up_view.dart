import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/padding_constants.dart';
import 'package:resq_map/core/text_styles.dart';
import 'package:resq_map/core/urls.dart';
import 'package:resq_map/core/validators/password_validator.dart';
import 'package:resq_map/features/authentication/cubit/cubit/auth_cubit.dart';
import 'package:resq_map/features/authentication/widgets/page_header.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({
    super.key,
    this.navigateTo,
  });

  final void Function()? navigateTo;
  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  late GlobalKey<FormState> signUpKey;
  late List<String> labels;
  late List<Widget> prefixes;
  late List validators;
  @override
  void initState() {
    signUpKey = GlobalKey<FormState>();
    labels = ["Username", "E-Mail", "Phone Number", "Password"];
    prefixes = [
      const Icon(Icons.account_circle_outlined),
      const Icon(Icons.email_outlined),
      const Icon(Icons.phone_outlined),
      const Icon(Icons.lock_outline),
    ];
    validators = [
      (value) => value!.isEmpty ? 'Required' : null,
      (value) => value!.contains('@') ? null : 'Invalid email',
      (value) => value!.length >= 10 ? null : 'Too short',
      PasswordValidator.validate,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List controllers = [
     _usernameController,
     _emailController,
     _phoneNumberController,
     _passwordController
    ];
    return Form(
      key: signUpKey,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          PageHeader(
            titles: [
              Text(
                "Let's Create Your Account!",
                textAlign: TextAlign.center,
                style: TextStyles.textStyle18.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: PaddingConstants.spaceBtwSections),
            ],
          ),
          // First Name & Last Name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "First Name",
                    prefix: const Icon(Icons.person_outline),
                  ),
                  controller: _firstNameController,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Last Name",
                    prefix: const Icon(Icons.person_outline),
                  ),
                  controller: _lastNameController,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
              ),
            ],
          ),
          SizedBox(height: PaddingConstants.spaceBtwInputFields),
          Column(
  children: List.generate(labels.length,(index) => Padding(
        padding: const EdgeInsets.only(
          bottom: PaddingConstants.spaceBtwInputFields,
        ),
        child: TextFormField(
          controller: controllers[index],
          decoration: InputDecoration(
            labelText: labels[index],
            prefixIcon: prefixes[index],
          ),
          validator: (value) => value!.isEmpty ? 'Required' : null,
        ),
      ),
  ),
),
          const SizedBox(height: PaddingConstants.spaceBtwSections - 16),
          ElevatedButton(
            onPressed: () {
              if (signUpKey.currentState!.validate()) {
                signUpKey.currentState!.save();
                print({
                  "firstName": _firstNameController.text,
                  "lastName": _lastNameController.text,
                  "userName": controllers[0].text,
                  "email": controllers[1].text,
                  "phoneNumber": controllers[2].text,
                  "password": controllers[3].text,
                });
                BlocProvider.of<AuthCubit>(
                  context,
                ).generateOTP(verifyEmailUrl, {
                  "first_name": _firstNameController.text,
                  "last_name": _lastNameController.text,
                  "username": controllers[0].text,
                  "email": controllers[1].text,
                  "phone_number": controllers[2].text,
                  "password": controllers[3].text,
                });
              }
            },
            child: Text("Create Account"),
          ),
        ],
      ),
    );
  }
}
