import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/strings/strings.dart';
import 'package:my_dictionary/hive_helper/hive_helper.dart';
import 'package:my_dictionary/words/view/word_detail_view.dart';

import '../../service/service.dart';

abstract class WordDetailViewModel extends State<WordDeatilView> {
  bool isDelete = false;
  bool isUpdate = false;
  bool isOwner = true;
  bool isLoading = true;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController controllerWord;
  late final TextEditingController controllerTranslate;
  late final TextEditingController controllerWordSentencte;
  late final TextEditingController controllerTranslateSentence;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey();
    controllerWord = TextEditingController();
    controllerTranslate = TextEditingController();
    controllerWordSentencte = TextEditingController();
    controllerTranslateSentence = TextEditingController();
    Future.microtask(() {
      controlOwner();
    });
    _changeLoading();
  }

  void _changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void controlOwner() async {
    final String userNick = await HiveHelper.getNicknameFromLocale();
    if (widget.word?.userNick != userNick) {
      setState(() {
        isOwner = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    controllerWord.dispose();
    controllerTranslate.dispose();
    controllerWordSentencte.dispose();
    controllerTranslateSentence.dispose();
  }

  Future<String?> getUserKey() async {
    return await HiveHelper.getTokenFromLocale();
  }

  String? formValidator(String? value) {
    if (value == null || value.isEmpty) {
      return ProjectStrings.fieldFilledText;
    }
    return null;
  }

  Future<bool> updateWord(String? key, dynamic jsonWord) async {
    return await ProjectService().updateWordWithKey(key ?? ProjectStrings.nullText, jsonWord);
  }

  Future<bool> deleteWord(String key) async {
    return await ProjectService().deleteWordWithKey(key);
  }
}
