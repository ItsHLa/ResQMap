import 'package:flutter/material.dart';
import 'package:resq_map/app_page.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/features/authentication/utils/auth_service.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    
    initAnimation();
    getToken();
    navigateToHomePage();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.1,
            child: Image.asset(appicon),
          ),
          // AnimatedBuilder(
          //   animation: animation,
          //   builder:
          //       (context, child) => SlideTransition(
          //         position: animation,
          //         child: const Text(
          //           'Read Free Books',
          //           textAlign: TextAlign.center,
          //         ),
          //       ),
          // ),
        
        ],
      ),
    );
  }

  void navigateToHomePage() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => AppPage(
          token: token,
        ),)
      );
    });
  }



  String? token;

  Future<void> getToken() async {
    String? result = await AuthService.getAuthToken();
    setState(() {
      token = result;
    });
  }

  void initAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = Tween<Offset>(
      begin: const Offset(2, 0),
      end: Offset.zero,
    ).animate(animationController);
    animationController.forward();
  }
}


