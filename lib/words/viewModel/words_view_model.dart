import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_dictionary/route/route_enum.dart';
import 'package:my_dictionary/hive_helper/hive_helper.dart';
import 'package:my_dictionary/words/view/words_view.dart';

import '../model/word_model.dart';
import '../../service/service.dart';

abstract class WordsViewModel extends State<WordsView> {
  Future<List<Word>?>? myFuture;
  String? userNick;
  dynamic isReflesh = false;
  int? requestAmounth;

  @override
  void initState() {
    super.initState();
    myFuture = ProjectService().getWordswithUserKey(widget.userKey);
    Future.microtask(() async {
      String? userNick_ = await getUserName();
      getRequestAmount();
      setState(() {
        userNick = userNick_;
      });
    });
  }

  void updateState() {
    myFuture = ProjectService().getWordswithUserKey(widget.userKey);
  }

  Future<String?> getUserName() async {
    return await HiveHelper.getNicknameFromLocale();
  }

  void getRequestAmount() async {
    int? count = await ProjectService().getReqAmounth();
    setState(() {
      requestAmounth = count;
    });
  }

  Future<void> deleteHive() async {
    await HiveHelper.deleteUserFromLocale();
    Navigator.pushNamedAndRemoveUntil(context, RouteName.init.toRoute(), (route) => false);
  }
}
