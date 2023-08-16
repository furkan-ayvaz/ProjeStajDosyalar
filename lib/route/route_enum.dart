enum RouteName {
  init,
  home,
  signUp,
  words,
  addWord,
  wordDetail,
  showFriends,
  showFriendRequest,
  addFriend,
  friendWords,
}

extension RouteNameExtension on RouteName {
  String toRoute() {
    switch (this) {
      case RouteName.init:
        return "/";
      case RouteName.home:
        return "/$name";
      case RouteName.signUp:
        return "/$name";
      case RouteName.words:
        return "/$name";
      case RouteName.addWord:
        return "/$name";
      case RouteName.wordDetail:
        return "/$name";
      case RouteName.showFriends:
        return "/$name";
      case RouteName.showFriendRequest:
        return "/$name";
      case RouteName.addFriend:
        return "/$name";
      case RouteName.friendWords:
        return "/$name";
    }
  }
}
