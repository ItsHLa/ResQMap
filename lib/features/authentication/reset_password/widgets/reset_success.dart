import 'package:flutter/material.dart';
import 'package:resq_map/core/padding_constants.dart';
import 'package:resq_map/core/text_styles.dart';

class ResetSuccessScreen extends StatelessWidget {
  const ResetSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: PaddingConstants.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 24),
             Text(
              'Password Reset Successful!',
              style: TextStyles.textStyle18.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
             Text(
              'Your password has been updated successfully',
              textAlign: TextAlign.center,
              style: TextStyles.textStyle16,
            ),
            const SizedBox(height: PaddingConstants.spaceBtwSections),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
             
              child: Center(child: const Text('Back to Login')),
            ),
          ],
        ),
      ),
    );
  }
}
