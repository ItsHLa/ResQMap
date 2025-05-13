import 'package:flutter/material.dart';
import 'package:resq_map/core/constants.dart';
import 'package:resq_map/core/padding_constants.dart';
import 'package:resq_map/core/text_styles.dart';
import 'package:resq_map/features/authentication/pages/sign_up_view.dart';
import 'package:resq_map/features/authentication/widgets/form_fields.dart';
import 'package:resq_map/features/authentication/widgets/page_header.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool? rememberMe = false;
  final _loginkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: PaddingConstants.xl),
        child: Form(
          key: _loginkey,
          child: ListView(
            children: [
              PageHeader(
                titles: [
                  const Text(
                    'Welcome back!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to continue',
                    textAlign: TextAlign.start,
                    style: TextStyles.textStyle14.copyWith(color: Colors.grey.shade600),
                  ),
                ],
              ),
              const SizedBox(height: PaddingConstants.spaceBtwInputFields),
              FormFields(
                labelTexts: ["E-Mail", "Password"],
                validators: [
                  (value) =>
                      value?.contains('@') ?? false ? null : 'Invalid email',
                ],
                prefixes: [
                  Icon(Icons.alternate_email),
                  Icon(Icons.lock_outline),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                    Checkbox(
                        activeColor: appThemeColor,
                    semanticLabel: "Remember Me",
                    value: rememberMe, 
                    onChanged: (value) => setState(() {
                      rememberMe = value;
                    }),),
                    Text("Remember Me", style: TextStyles.textStyle14,),
                    ],
                  ),
                  TextButton(
                    
                    style: TextButton.styleFrom(
                      textStyle:TextStyles.textStyle12 ,
                      padding: EdgeInsets.zero),
                    onPressed: () {},
                    child: Text(
                      "Forget Password?",
                      
                    ),
                  ),
                ],
              ),
              SizedBox(height: PaddingConstants.spaceBtwSections),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appThemeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text("Login", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: PaddingConstants.spaceBtwInputFields),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  side: BorderSide(color: appThemeColor),
                ),
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => SignUpView()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Create Account",
                    style: TextStyle(color: appThemeColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
