import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/strings/strings.dart';
import 'package:my_dictionary/sign_in_up/view/splash_container.dart';
import 'package:my_dictionary/words/view/words_view.dart';
import 'package:my_dictionary/words/viewModel/friend_words_view_model.dart';

class FriendWordsView extends StatefulWidget {
  FriendWordsView({required this.userKey, super.key});
  String userKey;
  @override
  State<FriendWordsView> createState() => _FriendWordsViewState();
}

class _FriendWordsViewState extends FriendWordsViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isLoading ? const Text(ProjectStrings.nullText) : Text("$userNick"),
      ),
      body: isLoading ? const SplashContainer() : CustomFutureBuilder(myFuture: myFuture),
    );
  }
}
