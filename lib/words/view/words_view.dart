// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/padding/custom_padding.dart';
import 'package:my_dictionary/constant/color/colors.dart';
import 'package:my_dictionary/constant/strings/strings.dart';
import 'package:my_dictionary/route/route_enum.dart';

import 'package:my_dictionary/words/viewModel/words_view_model.dart';

import '../../sign_in_up/view/splash_container.dart';
import '../model/word_model.dart';
import 'custom_row.dart';

class WordsView extends StatefulWidget {
  WordsView({super.key, required this.userKey});
  String userKey;
  @override
  State<WordsView> createState() => _WordsViewState();
}

class _WordsViewState extends WordsViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: ProjectLightColor.darkColor),
            child: Center(
                child: Text(
              userNick ?? ProjectStrings.wentWrongText,
              style: Theme.of(context).textTheme.headline5,
            )),
          ),
          ListTile(
            leading: const Icon(Icons.group_add_outlined),
            title: const Text(ProjectStrings.showFriendText),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, RouteName.showFriends.toRoute());
            },
          ),
          ListTile(
            leading: const Icon(Icons.group_add_outlined),
            title: const Text(ProjectStrings.addFriendText),
            onTap: () {
              Navigator.pushNamed(context, RouteName.addFriend.toRoute());
            },
          ),
          ListTile(
            leading: const Icon(Icons.group_rounded),
            title: const Text(ProjectStrings.friendReqText),
            /*trailing: SizedBox(
              width: 20,
              height: 20,
              child: Text("$requestAmounth"),
            ),*/
            onTap: () {
              Navigator.pushNamed(context, RouteName.showFriendRequest.toRoute());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text(ProjectStrings.logOutText),
            onTap: () async {
              await deleteHive();
            },
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          isReflesh = await Navigator.pushNamed(context, RouteName.addWord.toRoute());
          if (isReflesh is bool) {
            if (isReflesh != false) {
              setState(() {
                updateState();
              });
            }
          }
        },
        child: const Icon(Icons.add),
      ),
      body: CustomFutureBuilder(
        myFuture: myFuture,
      ),
    );
  }
}

class CustomFutureBuilder extends StatefulWidget {
  const CustomFutureBuilder({
    Key? key,
    required this.myFuture,
  }) : super(key: key);

  final Future<List<Word>?>? myFuture;
  @override
  State<CustomFutureBuilder> createState() => _CustomFutureBuilderState();
}

class _CustomFutureBuilderState extends State<CustomFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProjectPadding.defaultPadding,
      child: FutureBuilder(
        future: widget.myFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Word>? wordList = snapshot.data;
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: wordList?.length ?? 0,
              itemBuilder: (context, index) {
                return _ListViewInkwellCard(word: wordList?[index] ?? Word());
              },
            );
          } else if (snapshot.hasError) {
            return const Text(ProjectStrings.wentWrongText);
          } else {
            return const SplashContainer();
          }
        },
      ),
    );
  }
}

class _ListViewInkwellCard extends StatelessWidget {
  const _ListViewInkwellCard({
    Key? key,
    required this.word,
  }) : super(key: key);

  final Word? word;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteName.wordDetail.toRoute(), arguments: word);
      },
      child: Card(
        elevation: 15,
        color: ProjectLightColor.darkColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomRow(
              txt: word?.txtFirst,
            ),
            const Spacer(),
            CustomRow2(
              txt: word?.txtSecond,
            ),
          ],
        ),
      ),
    );
  }
}
