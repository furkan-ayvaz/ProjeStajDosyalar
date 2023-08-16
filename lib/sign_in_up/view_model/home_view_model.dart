import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/strings/strings.dart';
import 'package:my_dictionary/hive_helper/hive_helper.dart';

import '../../service/service.dart';
import '../view/home_view.dart';

abstract class HomeViewModel extends State<HomeView> {
  bool isLogin = false;

  late final TextEditingController controllerNickName;
  late final TextEditingController controllerPassword;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    controllerNickName = TextEditingController();
    controllerPassword = TextEditingController();
    formKey = GlobalKey();
  }

  @override
  void dispose() {
    super.dispose();
    controllerNickName.dispose();
    controllerPassword.dispose();
  }

  Future<String?> getUserKey() async {
    return await HiveHelper.getTokenFromLocale();
  }

  String? validatorNickname(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.length >= 3) {
        return null;
      } else {
        return ProjectStrings.userNickLengthText;
      }
    } else {
      return ProjectStrings.fieldFilledText;
    }
  }

  String? validatorPassword(String? value) {
    if (value == null || value.isEmpty) {
      return ProjectStrings.fieldFilledText;
    } else {
      if (value.length < 6) {
        return ProjectStrings.passwordLengthText;
      } else {
        return null;
      }
    }
  }

  Future<void> loginFunc() async {
    final isLogin_ = await ProjectService().loginUser(controllerNickName.text, controllerPassword.text);
    setState(() {
      isLogin = isLogin_;
    });
  }
}
