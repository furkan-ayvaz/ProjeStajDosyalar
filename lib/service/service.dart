import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_dictionary/hive_helper/hive_helper.dart';

import '../sign_in_up/model/user_model.dart';
import '../words/model/word_model.dart';

abstract class _ServiceManager {
  final String _base = "https://wordappdb-default-rtdb.europe-west1.firebasedatabase.app";

  Future<User?> getSpecificUser(String nickName);
  Future<String?> getSpecificUserWithUserKey(String userKey);
  Future<List<Word>?> getWordswithUserKey(String userKey);
  Future<bool> postWordWithNickname(Map<String, dynamic>? body);
  Future<bool> deleteWordWithKey(String key);
  Future<bool> updateWordWithKey(String key, dynamic body);
  Future<bool> signUpUser(dynamic body, String nickname);
  Future<bool> isUniqueNickName(String nickname);
  Future<bool> loginUser(String nickname, String password);
  Future<List<Map<String, dynamic>?>?> getFollowingSpecificUser();
  Future<bool> addFriend(String nickname);
  Future<List<Map<String, dynamic>?>?> showFriendRequest();
  Future<bool> acceptFriendRequest(String nickName, String reqKey);
  Future<bool> deleteFriendRequest(String reqKey, {String? nickname});
  Future<int?> getReqAmounth();
}

class ProjectService extends _ServiceManager {
  @override
  Future<User?> getSpecificUser(String nickName) async {
    final response = await http.get(Uri.parse('$_base/users/.json?orderBy="nickname"&equalTo="$nickName"'));
    Map<String, dynamic> jsonTemp = {};
    if (response.statusCode == HttpStatus.ok) {
      final jsonModel = json.decode(response.body) as Map;
      jsonModel.forEach((key, value) {
        final List<Map<String, dynamic>?> strFollowerReq = [];
        final List<Map<String, dynamic>?> strFollowing = [];
        Map following = value["following"] ?? {};
        Map followerReq = value["follow_req"] ?? {};
        followerReq.forEach((key, value) {
          String tempKey = key;
          Map innerMap = value;
          innerMap.forEach((key, value) {
            final Map<String, dynamic> tempMap = {tempKey: value};
            strFollowerReq.add(tempMap);
          });
        });
        following.forEach((key, value) {
          String tempKey = key;
          Map innerMap2 = value;
          innerMap2.forEach((key, value) {
            final Map<String, dynamic> tempMap = {tempKey: value};
            strFollowing.add(tempMap);
          });
        });
        jsonTemp = {
          "key": key,
          "name": value["name"],
          "nickname": value["nickname"],
          "surname": value["surname"],
          "following": strFollowing,
          "follow_req": strFollowerReq,
          "password": value["password"]
        };
      });
      return User.fromJson(jsonTemp);
    }
    return null;
  }

  @override
  Future<List<Word>?> getWordswithUserKey(String userKey) async {
    final response = await http.get(Uri.parse('$_base/words.json?orderBy="user_key"&equalTo="$userKey"'));
    List<Word> wordlist = [];
    if (response.statusCode == HttpStatus.ok) {
      final data = json.decode(response.body) as Map;
      data.forEach((key, value) {
        final tempWord = Word.fromJson(value);
        tempWord.key = key;
        wordlist.add(tempWord);
      });
      return wordlist;
    }
    return null;
  }

  @override
  Future<bool> postWordWithNickname(dynamic body) async {
    final response = await http.post(Uri.parse("$_base/words.json"), body: body);
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> deleteWordWithKey(String key) async {
    final response = await http.delete(Uri.parse("$_base/words/$key.json"));
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> updateWordWithKey(String key, dynamic body) async {
    final response = await http.put(Uri.parse("$_base/words/$key.json"), body: body);
    if (response.statusCode == HttpStatus.ok) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> signUpUser(dynamic body, String nickname) async {
    final response = await http.post(Uri.parse("$_base/users.json"), body: body);
    if (response.statusCode == HttpStatus.ok) {
      final jsonBody = json.decode(response.body) as Map;

      await HiveHelper.addUsertoLocale(nickname, jsonBody["name"]);
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> isUniqueNickName(String? nickname) async {
    final response = await http.get(Uri.parse('$_base/users/.json?orderBy="nickname"&equalTo="$nickname"'));
    final responseBody = json.decode(response.body) as Map;
    if (responseBody.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> loginUser(String nickname, String password) async {
    final response = await http.get(Uri.parse('$_base/users.json?orderBy="nickname"&equalTo="$nickname"'));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body) as Map;
      if (jsonBody.isEmpty) {
        return false;
      } else {
        bool isTrue = false;
        String nickname = "";
        String userKey = "";
        jsonBody.forEach((key, value) {
          if (value["password"] == password) {
            nickname = value["nickname"];
            userKey = key;
            isTrue = true;
          } else {
            isTrue = false;
          }
        });

        await HiveHelper.addUsertoLocale(nickname, userKey);
        return isTrue;
      }
    } else {
      return false;
    }
  }

  @override
  Future<List<Map<String, dynamic>?>?> getFollowingSpecificUser() async {
    final userNick = await HiveHelper.getNicknameFromLocale();
    User? user = await getSpecificUser(userNick);
    if (user?.nickname?.isNotEmpty ?? false) {
      return user?.following ?? [];
    }
    return null;
  }

  @override
  Future<bool> addFriend(String nickname) async {
    User? user = await getSpecificUser(nickname);
    if (user?.key?.isNotEmpty ?? false) {
      final userNick = await HiveHelper.getNicknameFromLocale();
      final tempBody = {"name": userNick};
      final jsonTempBody = json.encode(tempBody);
      final response = await http.post(Uri.parse("$_base/users/${user!.key}/follow_req.json"), body: jsonTempBody);
      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<List<Map<String, dynamic>?>?> showFriendRequest() async {
    final userNick = await HiveHelper.getNicknameFromLocale();
    User? tempUser = await getSpecificUser(userNick);
    if (tempUser?.nickname?.isNotEmpty ?? false) {
      return tempUser?.followReq ?? [];
    }
    return null;
  }

  @override
  Future<bool> acceptFriendRequest(String reqNickname, String reqKey) async {
    User? tempUser = await getSpecificUser(reqNickname);
    if (tempUser?.key?.isNotEmpty ?? false) {
      final userNick = await HiveHelper.getNicknameFromLocale();
      final tempBody = {"name": userNick};
      final jsonTempBody = json.encode(tempBody);
      final response = await http.post(Uri.parse("$_base/users/${tempUser!.key}/following.json"), body: jsonTempBody);
      if (response.statusCode == HttpStatus.ok) {
        bool isDeleted = await deleteFriendRequest(reqKey, nickname: userNick);
        if (isDeleted) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<bool> deleteFriendRequest(String reqKey, {String? nickname}) async {
    if (nickname?.isEmpty ?? true) {
      nickname = await HiveHelper.getNicknameFromLocale();
    }
    User? tempUser = await getSpecificUser(nickname!);
    if (tempUser?.key?.isNotEmpty ?? false) {
      final response = await http.delete(Uri.parse("$_base/users/${tempUser!.key}/follow_req/$reqKey.json"));
      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<String?> getSpecificUserWithUserKey(String userKey) async {
    final response = await http.get(Uri.parse('$_base/users/$userKey.json'));
    if (response.statusCode == HttpStatus.ok) {
      final jsonBody = json.decode(response.body) as Map;
      return jsonBody["nickname"];
    }
    return null;
  }

  @override
  Future<int?> getReqAmounth() async {
    final userNick = await HiveHelper.getNicknameFromLocale();
    User? user = await getSpecificUser(userNick);
    if (user?.nickname?.isNotEmpty ?? false) {
      return user?.followReq?.length;
    }
    return null;
  }
}
