import 'package:flutter/material.dart';
import 'package:resq_map/core/constants.dart';
import 'package:resq_map/core/padding_constants.dart';
import 'package:resq_map/core/text_styles.dart';
import 'package:resq_map/core/widget/input_field.dart';
import 'package:resq_map/features/authentication/widgets/form_fields.dart';
import 'package:resq_map/features/authentication/widgets/page_header.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _loginkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _loginkey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: PaddingConstants.xl),
          children: [
            PageHeader(
              titles: [
                 Text(
          "Let's Create Your Account!",
          textAlign: TextAlign.center,
          style: TextStyles.textStyle18.copyWith(fontWeight:FontWeight.bold ),
        ),
       SizedBox(height: PaddingConstants.spaceBtwSections,)
        ],),
            // First Name & Last Name
            Row(
              children: [
                Expanded(
                  child: Field(
                    labelText: "First Name",
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                    prefix: const Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Field(
                    labelText: "Last Name",
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                    prefix: const Icon(Icons.person_outline),
                  ),
                ),
              ],
            ),
            SizedBox(height: PaddingConstants.spaceBtwInputFields),
            // Remaining Fields
            FormFields(
              labelTexts: ["Username", "E-Mail", "Phone Number", "Password"],
              validators: [
                (value) => value!.isEmpty ? 'Required' : null,
                (value) => value!.contains('@') ? null : 'Invalid email',
                (value) => value!.length >= 10 ? null : 'Too short',
                (value) => value!.length >= 6 ? null : 'Min 6 characters',
              ],
              prefixes: [
                const Icon(Icons.account_circle_outlined),
                const Icon(Icons.alternate_email),
                const Icon(Icons.phone_outlined),
                const Icon(Icons.lock_outline),
              ],
            ),
            const SizedBox(height: PaddingConstants.spaceBtwSections -16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: appThemeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "Create Account",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
