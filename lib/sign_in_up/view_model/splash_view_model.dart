import 'package:my_dictionary/hive_helper/hive_helper.dart';
import 'package:my_dictionary/route/route_enum.dart';
import 'package:my_dictionary/sign_in_up/view/splash_view.dart';

import 'package:flutter/material.dart';

abstract class SplashViewModel extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    connectHive();
  }

  Future<void> connectHive() async {
    String? userKey = await HiveHelper.getTokenFromLocale();
    if (userKey != null) {
      Navigator.pushNamedAndRemoveUntil(context, RouteName.words.toRoute(), (route) => false, arguments: userKey);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, RouteName.home.toRoute(), (route) => false);
    }
  }
}
