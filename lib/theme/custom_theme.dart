import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/color/colors.dart';

class CustomTheme {
  ThemeData customTheme = ThemeData.light().copyWith(
    appBarTheme: _CustomThemeComponenet()._customAppBarTheme,
  );
}

class _CustomThemeComponenet {
  final AppBarTheme _customAppBarTheme = ThemeData.light().appBarTheme.copyWith(color: ProjectLightColor.darkColor);
}
