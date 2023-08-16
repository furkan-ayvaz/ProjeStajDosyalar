import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveHelper {
  static Future<void> addUsertoLocale(String nickname, String token) async {
    await Hive.initFlutter();
    await Hive.openBox("tokenBox");
    final box = Hive.box("tokenBox");
    await box.put("nickname", nickname);
    await box.put("token", token);
    await box.close();
  }

  static Future<String> getNicknameFromLocale() async {
    await Hive.initFlutter();
    await Hive.openBox("tokenBox");
    final box = Hive.box("tokenBox");
    final userNick = await box.get("nickname");
    await box.close();
    return userNick;
  }

  static Future<String?> getTokenFromLocale() async {
    await Hive.initFlutter();
    await Hive.openBox("tokenBox");
    final box = Hive.box("tokenBox");
    final token = await box.get("token");
    await box.close();
    return token;
  }

  static Future<void> deleteUserFromLocale() async {
    await Hive.initFlutter();
    await Hive.openBox("tokenBox");
    final box = Hive.box("tokenBox");
    await box.delete("token");
    await box.delete("nickname");
    await box.close();
  }
}
