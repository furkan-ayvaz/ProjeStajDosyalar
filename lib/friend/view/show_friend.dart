import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/strings/strings.dart';
import 'package:my_dictionary/friend/viewModel/show_friend_view_model.dart';
import 'package:my_dictionary/route/route_enum.dart';
import 'package:my_dictionary/sign_in_up/view/splash_container.dart';

import 'no_friend_or_request_view.dart';

class ShowFriendView extends StatefulWidget {
  const ShowFriendView({super.key});

  @override
  State<ShowFriendView> createState() => _ShowFriendViewState();
}

class _ShowFriendViewState extends ShowFriendViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: (isLoading)
            ? const SplashContainer()
            : (userNameList?.isEmpty ?? true)
                ? const NoFriendorRequestView(text: ProjectStrings.noFriendText)
                : ListView.builder(
                    itemCount: userNameList?.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () async {
                            await getUserKey(userNameList![index]!.values.first);
                            Navigator.pushNamed(context, RouteName.friendWords.toRoute(), arguments: userKey);
                          },
                          leading: const Icon(Icons.person_outline),
                          title: Text(
                            "${userNameList?[index]?.values.first ?? "no data"}",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          trailing: const Icon(Icons.chevron_right_outlined),
                        ),
                      );
                    },
                  ));
  }
}
