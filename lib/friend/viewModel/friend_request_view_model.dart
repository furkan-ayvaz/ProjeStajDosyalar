import 'package:flutter/material.dart';

import '../../service/service.dart';
import '../view/friend_request.dart';

abstract class FriendRequestViewModel extends State<FriendRequestView> {
  List<Map<String, dynamic>?>? requestList;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      _changeLoading();
      List<Map<String, dynamic>?>? requestLists = await getRequestList();
      setState(() {
        requestList = requestLists;
      });
      _changeLoading();
    });
  }

  Future<bool> acceptFriendRequest(String reqNickName, String reqKey) async {
    return await ProjectService().acceptFriendRequest(reqNickName, reqKey);
  }

  Future<bool> deleteFriendRequest(String reqKey) async {
    return await ProjectService().deleteFriendRequest(reqKey);
  }

  void _changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<List<Map<String, dynamic>?>?> getRequestList() async {
    return await ProjectService().showFriendRequest();
  }
}
