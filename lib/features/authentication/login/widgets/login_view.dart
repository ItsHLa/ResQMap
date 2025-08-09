import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/core/constants/padding_constants.dart';
import 'package:resq_map/core/constants/text_styles.dart';
import 'package:resq_map/core/validators/password_validator.dart';
import 'package:resq_map/features/authentication/cubit/cubit/auth_cubit.dart';
import 'package:resq_map/features/authentication/reset_password/pages/email_step_page.dart';
import 'package:resq_map/features/authentication/sign_up/pages/sign_up_page.dart';
import 'package:resq_map/features/authentication/widgets/page_header.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late List labels;
  late List validators;
  late GlobalKey<FormState> loginkey;
  late List controllers;
  bool obscureText = true;

  @override
  void initState() {
    labels = ["E-Mail", "Password"];
    validators = [
      (value) {
        if (value == null) {
          return "E-Mail can't be empty";
        } else if (value.isEmpty) {
          return "E-Mail can't be empty";
        } else if (!value.contains('@')) {
          return 'Invalid email';
        } else {
          return null;
        }
      },
      PasswordValidator.validate,
    ];
    loginkey = GlobalKey<FormState>();
    controllers = [TextEditingController(), TextEditingController()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> prefixes = [
      Icon(Icons.email_outlined),
      Icon(Icons.lock_outline),
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: PaddingConstants.xl),
        child: Form(
          key: loginkey,
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
                    style: TextStyles.textStyle14.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: PaddingConstants.spaceBtwInputFields),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: labels.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: PaddingConstants.spaceBtwInputFields,
                    ),
                    child: TextFormField(
                      obscureText: index == 1 ? obscureText : false,
                      decoration: InputDecoration(
                        
                        suffix: index == 1 ? IconButton(onPressed: (){
                          setState(() {
                            obscureText = !obscureText;
                          });
                        }, icon: Icon(Icons.remove_red_eye_outlined)): null,
                        labelText: labels[index],
                        prefixIcon: prefixes[index],
                      ),
                      controller: controllers[index],
                      validator: validators[index],
                      onSaved: (value) {
                       
                      },
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: TextStyles.textStyle12,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EmailStepPage(),
                        ),
                      );
                    },
                    child: Text("Forget Password?"),
                  ),
                ],
              ),
              SizedBox(height: PaddingConstants.spaceBtwSections),

              ElevatedButton(
                onPressed: () {
                  if (loginkey.currentState!.validate()) {
                    loginkey.currentState!.save();
                    BlocProvider.of<AuthCubit>(context).logIn({
                      "email": controllers[0].text,
                      "password": controllers[1].text,
                    });
                  }
                },
                child: Text("Login"),
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
                  Navigator.of(context,).push(
                    MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: Text(
                  "Create Account",
                  style: TextStyle(color: appThemeColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
