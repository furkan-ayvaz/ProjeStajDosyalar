import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/strings/strings.dart';
import 'package:my_dictionary/route/custom_route.dart';
import 'package:my_dictionary/theme/custom_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ProjectStrings.projectNameText,
      theme: CustomTheme().customTheme,
      onGenerateRoute: CustomRoute.onGenerateRoute,
    );
  }
}
