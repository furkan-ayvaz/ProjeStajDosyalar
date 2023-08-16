import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_dictionary/constant/strings/strings.dart';
import 'package:my_dictionary/service/service.dart';
import 'package:my_dictionary/words/view/add_word.dart';

import '../model/word_model.dart';

abstract class AddWordViewModel extends State<AddWordView> {
  late final TextEditingController wordTextController;
  late final TextEditingController translateTextController;
  late final TextEditingController example1TextController;
  late final TextEditingController example2TextController;
  late final GlobalKey<FormState> formKey;
  late final Word? tempWord;
  @override
  void initState() {
    super.initState();
    tempWord = Word();
    wordTextController = TextEditingController();
    translateTextController = TextEditingController();
    example1TextController = TextEditingController();
    example2TextController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    wordTextController.dispose();
    translateTextController.dispose();
    example1TextController.dispose();
    example2TextController.dispose();
  }

  Future<String?> getUserKey() async {
    await Hive.initFlutter();
    await Hive.openBox("tokenBox");
    final box = Hive.box("tokenBox");
    return await box.get("token");
  }

  Future<String?> getNickname() async {
    await Hive.initFlutter();
    await Hive.openBox("tokenBox");
    final box = Hive.box("tokenBox");
    return await box.get("nickname");
  }

  String? formValidator(String? value) {
    if (value == null || value.isEmpty) {
      return ProjectStrings.fieldFilledText;
    }
    return null;
  }

  Future<bool> addWord(dynamic body) async {
    return await ProjectService().postWordWithNickname(body);
  }
}
