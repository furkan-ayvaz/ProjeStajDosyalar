import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/border/custom_border.dart';
import 'package:my_dictionary/constant/padding/custom_padding.dart';
import 'package:my_dictionary/constant/color/colors.dart';
import 'package:my_dictionary/constant/strings/strings.dart';
import 'package:my_dictionary/friend/viewModel/add_friend_view_model.dart';

import '../../sign_in_up/model/user_model.dart';

class AddFriendView extends StatefulWidget {
  const AddFriendView({super.key});

  @override
  State<AddFriendView> createState() => _AddFriendViewState();
}

class _AddFriendViewState extends AddFriendViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(ProjectStrings.addFriendText),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: _boxDecorationForAddFriend(),
                child: Form(
                    key: formKey,
                    child: isFriend
                        ? _isFriendTrue()
                        : Row(
                            children: [
                              _formFieldUserNick(),
                              _searchButton(),
                            ],
                          )),
              ),
            ),
            isLoading
                ? const SizedBox()
                : Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.07),
                    child: Card(
                        child: ListTile(
                      title: Text(user?.nickname ?? ProjectStrings.dataNullText),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        IconButton(
                            onPressed: () async {
                              if (isFriend == false) {
                                bool isOkey = await addFriend(user?.nickname ?? ProjectStrings.nullText);
                                if (isOkey) {
                                  Navigator.pop(context);
                                }
                              }
                            },
                            icon: const Icon(Icons.person_add_alt_1_rounded)),
                        removePeopleFromList()
                      ]),
                    )),
                  )
          ],
        ));
  }

  BoxDecoration _boxDecorationForAddFriend() {
    return BoxDecoration(
        gradient: const LinearGradient(
            colors: [ProjectLightColor.darkColor, ProjectLightColor.lightColor],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft),
        border: ProjectBorder.addFriendBoxBorder,
        borderRadius: ProjectBorder.addFriendBoxRadius);
  }

  IconButton removePeopleFromList() {
    return IconButton(
        onPressed: () {
          setState(() {
            isLoading = true;
            isFriend = false;
            user = User();
          });
          controllerNickname.text = ProjectStrings.nullText;
        },
        icon: const Icon(Icons.person_remove_alt_1_rounded));
  }

  Expanded _searchButton() {
    return Expanded(
      flex: 2,
      child: IconButton(onPressed: _searchOnpressed, icon: const Icon(Icons.search_outlined)),
    );
  }

  void _searchOnpressed() async {
    setState(() {
      user = User();
      isLoading = true;
      isThere = false;
    });
    final userS = await getUser(controllerNickname.text);
    if (userS!.nickname != null) {
      setState(() {
        isThere = true;
        user = userS;
      });
    }
    if (formKey.currentState?.validate() ?? false) {
      final followingList = await getFollowing();
      if (followingList?.isNotEmpty ?? false) {
        for (var e in followingList!) {
          if (e?.values.first == controllerNickname.text) {
            setState(() {
              isFriend = true;
              isLoading = true;
            });
            break;
          } else {
            setState(() {
              isFriend = false;
              isLoading = false;
            });
          }
        }
      } else {
        setState(() {
          isFriend = false;
          isLoading = false;
        });
      }
    }
    controllerNickname.text = ProjectStrings.nullText;
  }

  Expanded _formFieldUserNick() {
    return Expanded(
      flex: 8,
      child: Padding(
        padding: ProjectPadding.defaultPadding,
        child: TextFormField(
          controller: controllerNickname,
          validator: validatorNickname,
          decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              label: Text(
                ProjectStrings.userNameText,
                style: TextStyle(
                  color: Colors.black54,
                ),
              )),
        ),
      ),
    );
  }

  Row _isFriendTrue() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(ProjectStrings.isFriendText),
        IconButton(
            onPressed: () {
              setState(() {
                isLoading = true;
                isFriend = false;
                isThere = false;
                user = User();
              });
              controllerNickname.text = ProjectStrings.nullText;
            },
            icon: const Icon(Icons.check_outlined))
      ],
    );
  }
}
