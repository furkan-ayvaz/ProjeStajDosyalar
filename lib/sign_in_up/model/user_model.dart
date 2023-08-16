// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  List<Map<String, dynamic>?>? followReq;
  List<Map<String, dynamic>?>? following;
  String? key;
  String? name;
  String? nickname;
  String? surname;
  String? password;
  User({this.followReq, this.following, this.key, this.name, this.nickname, this.surname, this.password});

  User.fromJson(Map<String, dynamic> json) {
    key = json["key"];
    name = json["name"];
    nickname = json["nickname"];
    surname = json["surname"];
    following = json["following"];
    followReq = json["follow_req"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['name'] = name;
    data['nickname'] = nickname;
    data['surname'] = surname;
    data['followers'] = following;
    data['follow_req'] = followReq;
    data['password'] = password;
    return data;
  }

  User copyWith({
    List<Map<String, dynamic>?>? followReq,
    List<Map<String, dynamic>?>? following,
    String? key,
    String? name,
    String? nickname,
    String? surname,
    String? password,
  }) {
    return User(
      followReq: followReq ?? this.followReq,
      following: following ?? this.following,
      key: key ?? this.key,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      surname: surname ?? this.surname,
      password: password ?? this.password,
    );
  }
}
