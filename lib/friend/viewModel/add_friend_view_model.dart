import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/strings/strings.dart';

import '../../service/service.dart';
import '../../sign_in_up/model/user_model.dart';
import '../view/add_friend.dart';

abstract class AddFriendViewModel extends State<AddFriendView> {
  User? user;
  bool isThere = false;
  bool isFriend = false;
  bool isLoading = true;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController controllerNickname;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey();
    controllerNickname = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controllerNickname.dispose();
  }

  Future<User?> getUser(String nickname) async {
    return await ProjectService().getSpecificUser(nickname);
  }

  Future<List<Map<String, dynamic>?>?> getFollowing() async {
    return await ProjectService().getFollowingSpecificUser();
  }

  Future<bool> addFriend(String nickname) async {
    return await ProjectService().addFriend(nickname);
  }

  String? validatorNickname(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.length >= 3) {
        if (isThere == false) {
          return ProjectStrings.userNickNotFoundText;
        } else {
          return null;
        }
      } else {
        return ProjectStrings.userNickLengthText;
      }
    } else {
      return ProjectStrings.fieldFilledText;
    }
  }
}
