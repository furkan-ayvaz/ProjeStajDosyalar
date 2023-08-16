import 'package:flutter/material.dart';

import '../../service/service.dart';
import '../../sign_in_up/model/user_model.dart';
import '../view/show_friend.dart';

abstract class ShowFriendViewModel extends State<ShowFriendView> {
  List<Map<String, dynamic>?>? userNameList;
  bool isLoading = false;
  String? userKey;
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      List<Map<String, dynamic>?>? userNameListc = await getFollowers();
      setState(() {
        userNameList = userNameListc;
      });
    });
  }

  Future<void> getUserKey(String nickname) async {
    User? user = await ProjectService().getSpecificUser(nickname);
    if (user?.key?.isNotEmpty ?? false) {
      setState(() {
        userKey = user!.key;
      });
    }
  }

  Future<List<Map<String, dynamic>?>?> getFollowers() async {
    _changeLoading();
    final list = await ProjectService().getFollowingSpecificUser();
    _changeLoading();
    return list;
  }

  void _changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
