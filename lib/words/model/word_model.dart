// ignore_for_file: public_member_api_docs, sort_constructors_first
class Word {
  String? key;
  String? txtFirst;
  String? txtFirstExample;
  String? txtSecond;
  String? txtSecondExample;
  String? userKey;
  String? userNick;

  Word(
      {this.key,
      this.txtFirst,
      this.txtFirstExample,
      this.txtSecond,
      this.txtSecondExample,
      this.userKey,
      this.userNick});

  Word.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    txtFirst = json['txt_first'];
    txtFirstExample = json['txt_first_example'];
    txtSecond = json['txt_second'];
    txtSecondExample = json['txt_second_example'];
    userKey = json['user_key'];
    userNick = json['user_nick'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['txt_first'] = txtFirst;
    data['txt_first_example'] = txtFirstExample;
    data['txt_second'] = txtSecond;
    data['txt_second_example'] = txtSecondExample;
    data['user_key'] = userKey;
    data['user_nick'] = userNick;
    return data;
  }

  Word copyWith({
    String? key,
    String? txtFirst,
    String? txtFirstExample,
    String? txtSecond,
    String? txtSecondExample,
    String? userKey,
    String? userNick,
  }) {
    return Word(
      key: key ?? this.key,
      txtFirst: txtFirst ?? this.txtFirst,
      txtFirstExample: txtFirstExample ?? this.txtFirstExample,
      txtSecond: txtSecond ?? this.txtSecond,
      txtSecondExample: txtSecondExample ?? this.txtSecondExample,
      userKey: userKey ?? this.userKey,
      userNick: userNick ?? this.userNick,
    );
  }
}
