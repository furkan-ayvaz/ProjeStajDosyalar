enum LottieFileName { lottie_word, lottie_splash, lottie_splash_2 }

extension LottieFileNameExtension on LottieFileName {
  static const String _basePath = "assets/lotties/";
  String toPath() {
    switch (this) {
      case LottieFileName.lottie_word:
        return "$_basePath$name.json";
      case LottieFileName.lottie_splash:
        return "$_basePath$name.json";
      case LottieFileName.lottie_splash_2:
        return "$_basePath$name.json";
    }
  }
}
