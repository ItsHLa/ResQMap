import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:resq_map/core/padding_constants.dart';
import 'package:resq_map/core/text_styles.dart';
import 'package:resq_map/core/urls.dart';
import 'package:resq_map/features/authentication/cubit/cubit/auth_cubit.dart';
import 'package:resq_map/features/authentication/reset_password/pages/new_password_page.dart';
import 'package:resq_map/features/authentication/utils/back_header_widget.dart';

class OtpVerificationPage extends StatefulWidget {
  final Map<String, dynamic> userData;
 

  final String purpose;

  const OtpVerificationPage({
    super.key,
    required this.userData,
    required this.purpose,

  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  bool _resendLoading = false;
  bool _isVerifying = false;
  int _resendCooldown = 30;
  late Timer _cooldownTimer;
  String? _errorMessage;

  @override
  void dispose() {
    _cooldownTimer.cancel();
   
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startCooldown();
  }

  void _startCooldown() {
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCooldown > 0) {
        setState(() => _resendCooldown--);
      } else {
        timer.cancel();
      }
    });
  }

  void _verifyOtp() async {
    if (_isVerifying) return;

    final otp = _otpController.text.trim();
    print(otp);
    // Basic validation
    if (otp.isEmpty) {
      setState(() => _errorMessage = 'Please enter the OTP code');
      return;
    }

    if (otp.length != 6) {
      setState(() => _errorMessage = 'OTP must be 6 digits');
      return;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(otp)) {
      setState(() => _errorMessage = 'OTP must contain only numbers');
      return;
    }

    setState(() {
      _errorMessage = null;
      _isVerifying = true;
    });

    try {
      const isValid = true;

      if (isValid) {
        widget.userData["otp"] = otp;
        switch (widget.purpose) {
          case "verify":
            BlocProvider.of<AuthCubit>(context).signUp(widget.userData);
            break;
          case "reset":
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewPasswordPage(
                  userData:widget.userData ,
                ),));
            break;
        }
      }
    } catch (e) {
      setState(() => _errorMessage = 'Verification failed. Please try again.');
    } finally {
      setState(() => _isVerifying = false);
    }
  }

  void _resendOtp() {
    if (_resendLoading) return;

    setState(() {
      _resendLoading = true;
      _resendCooldown = 30;
      _otpController.clear();
      _errorMessage = null;
    });
    print(widget.userData);
    BlocProvider.of<AuthCubit>(
      context,
    ).generateOTP(requestResetUrl, widget.userData);

    if (BlocProvider.of(context).state is AuthEmailVerify) {
      _startCooldown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(PaddingConstants.lg),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BackHeader(),
            const SizedBox(height: 40),
            Icon(Icons.verified, color: Colors.green, size: 80),
            const SizedBox(height: 24),
            Text(
              'Verify your email',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: 'OTP sent to ',
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: widget.userData["email"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: " \n Check your email and enter the code here.",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            PinCodeTextField(
              appContext: context,
              length: 6,
              controller: _otpController,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                fieldHeight: 55,
                fieldWidth: 45,
                activeFillColor: Colors.white,
                activeColor:
                    _errorMessage != null
                        ? Colors.red
                        : Theme.of(context).primaryColor,
                selectedColor:
                    _errorMessage != null
                        ? Colors.red
                        : Theme.of(context).primaryColor,
                inactiveColor:
                    _errorMessage != null
                        ? Colors.red.shade300
                        : Colors.grey.shade300,
              ),
              animationDuration: const Duration(milliseconds: 200),
              enableActiveFill: false,
              onChanged: (value) {
                if (_errorMessage != null) {
                  setState(() => _errorMessage = null);
                }
              },
              onCompleted: (value) => _verifyOtp(),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _verifyOtp,
              child: const Text('Continue'),
            ),
            const SizedBox(height: 24),
            Center(
              child:
                  _resendCooldown > 0
                      ? Text(
                        'Resend code in $_resendCooldown seconds',
                        style: TextStyles.textStyle14.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      )
                      : TextButton(
                        onPressed: _resendLoading ? null : _resendOtp,
                        child:
                            _resendLoading
                                ? const CircularProgressIndicator()
                                : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Didn't receive code?",
                                      style: TextStyles.textStyle14.copyWith(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: _resendOtp,
                                      child: const Text("Resend"),
                                    ),
                                  ],
                                ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
