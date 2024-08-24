import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/views/welcom_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.black,
      splash: Center(
        child: Lottie.asset('assets/images/Animation - 1724443175043.json'),
      ),
      nextScreen: const WelcomeView(),
      splashIconSize: 1000,
      duration: 4690,
    );
  }
}
