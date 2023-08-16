import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/strings/strings.dart';
import 'package:my_dictionary/friend/view/add_friend.dart';
import 'package:my_dictionary/friend/view/friend_request.dart';
import 'package:my_dictionary/friend/view/show_friend.dart';
import 'package:my_dictionary/route/route_enum.dart';
import 'package:my_dictionary/sign_in_up/view/home_view.dart';
import 'package:my_dictionary/sign_in_up/view/sign_up_view.dart';
import 'package:my_dictionary/words/view/add_word.dart';
import 'package:my_dictionary/words/view/friend_words.dart';
import 'package:my_dictionary/words/view/word_detail_view.dart';
import 'package:my_dictionary/words/view/words_view.dart';

import '../sign_in_up/view/splash_view.dart';
import '../words/model/word_model.dart';

class CustomRoute {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    final routes = routeSettings.name == ProjectStrings.INITILAZE_PAGE
        ? RouteName.init
        : RouteName.values.byName(routeSettings.name!.substring(1));
    final args = routeSettings.arguments;
    switch (routes) {
      case RouteName.init:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteName.home:
        return MaterialPageRoute(builder: ((context) => const HomeView()));
      case RouteName.signUp:
        return MaterialPageRoute(builder: ((context) => const SignUpView()));
      case RouteName.words:
        if (args is String) {
          return MaterialPageRoute(builder: ((context) => WordsView(userKey: args)));
        }
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteName.addWord:
        return MaterialPageRoute(builder: ((context) => const AddWordView()));
      case RouteName.wordDetail:
        if (args is Word) {
          return MaterialPageRoute(builder: (context) => WordDeatilView(word: args));
        }
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteName.showFriends:
        return MaterialPageRoute(builder: ((context) => const ShowFriendView()));
      case RouteName.showFriendRequest:
        return MaterialPageRoute(builder: (context) => const FriendRequestView());
      case RouteName.addFriend:
        return MaterialPageRoute(builder: (context) => const AddFriendView());
      case RouteName.friendWords:
        if (args is String) {
          return MaterialPageRoute(builder: (context) => FriendWordsView(userKey: args));
        }
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}
