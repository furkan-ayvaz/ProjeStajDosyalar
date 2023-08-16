import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/strings/strings.dart';
import 'package:my_dictionary/hive_helper/hive_helper.dart';

import '../../service/service.dart';
import '../view/sign_up_view.dart';

abstract class SignUpViewModel extends State<SignUpView> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController nameController;
  late final TextEditingController surnameController;
  late final TextEditingController nicknameController;
  late final TextEditingController passwordController;
  late final TextEditingController rPasswordController;
  bool isUnique = false;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey();
    nameController = TextEditingController();
    surnameController = TextEditingController();
    nicknameController = TextEditingController();
    passwordController = TextEditingController();
    rPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    surnameController.dispose();
    nicknameController.dispose();
    passwordController.dispose();
    rPasswordController.dispose();
  }

  Future<String?> getUserKey() async {
    return await HiveHelper.getTokenFromLocale();
  }

  String? formNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return ProjectStrings.fieldFilledText;
    }
    return null;
  }

  String? validatorIsUnique(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.length >= 3) {
        if (isUnique) {
          return null;
        } else {
          return ProjectStrings.takenNicknameText;
        }
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
        if (passwordController.text != rPasswordController.text) {
          return ProjectStrings.dontMatchPasswordText;
        } else {
          return null;
        }
      }
    }
  }

  Future<bool> isUniqueNickname(String nickname) async {
    return await ProjectService().isUniqueNickName(nickname);
  }

  Future<bool> signUp(dynamic body, String nickname) async {
    return await ProjectService().signUpUser(body, nickname);
  }
}
