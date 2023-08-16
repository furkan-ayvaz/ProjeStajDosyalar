import 'package:flutter/material.dart';
import 'package:my_dictionary/words/view/friend_words.dart';

import '../../service/service.dart';
import '../model/word_model.dart';

abstract class FriendWordsViewModel extends State<FriendWordsView> {
  Future<List<Word>?>? myFuture;
  String? userNick;
  bool isLoading = false;

  Future<String?> getUserName() async {
    return await ProjectService().getSpecificUserWithUserKey(widget.userKey);
  }

  void _changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    super.initState();
    myFuture = ProjectService().getWordswithUserKey(widget.userKey);
    Future.microtask(
      () async {
        _changeLoading();
        String? nickname = await getUserName();
        setState(() {
          userNick = nickname;
        });
        _changeLoading();
      },
    );
  }
}
