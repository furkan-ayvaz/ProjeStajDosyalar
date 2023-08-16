import 'package:flutter/material.dart';
import 'package:my_dictionary/sign_in_up/view_model/splash_view_model.dart';

import 'splash_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends SplashViewModel {
  @override
  Widget build(BuildContext context) {
    return const SplashContainer();
  }
}
