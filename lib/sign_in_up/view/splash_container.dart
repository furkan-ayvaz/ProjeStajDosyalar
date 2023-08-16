import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_dictionary/constant/color/colors.dart';

import '../../constant/path/path_creator.dart';

class SplashContainer extends StatelessWidget {
  const SplashContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ProjectLightColor.lightColor, ProjectLightColor.darkColor],
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Lottie.asset(
        LottieFileName.lottie_splash_2.toPath(),
      ),
    );
  }
}
