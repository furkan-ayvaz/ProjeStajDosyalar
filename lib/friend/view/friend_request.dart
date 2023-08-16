import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/strings/strings.dart';
import 'package:my_dictionary/friend/viewModel/friend_request_view_model.dart';
import 'package:my_dictionary/sign_in_up/view/splash_container.dart';

import 'no_friend_or_request_view.dart';

class FriendRequestView extends StatefulWidget {
  const FriendRequestView({
    super.key,
  });
  @override
  State<FriendRequestView> createState() => _FriendRequestViewState();
}

class _FriendRequestViewState extends FriendRequestViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const SplashContainer()
          : (requestList?.isEmpty ?? true)
              ? const NoFriendorRequestView(text: ProjectStrings.noFriendRequestText)
              : ListView.builder(
                  itemCount: requestList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(requestList?[index]?.values.first ?? ProjectStrings.dataNullText),
                        leading: const Icon(Icons.rule_folder_outlined),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  final resBool = await acceptFriendRequest(
                                      (requestList?[index]?.values.first ?? ProjectStrings.nullText),
                                      (requestList?[index]?.keys.first ?? ProjectStrings.nullText));
                                  if (resBool) {
                                    requestList?.removeAt(index);
                                    setState(() {});
                                  }
                                },
                                icon: const Icon(Icons.person_add_alt_outlined)),
                            IconButton(
                                onPressed: () async {
                                  final isDeleted = await deleteFriendRequest(
                                      requestList?[index]?.keys.first ?? ProjectStrings.nullText);
                                  if (isDeleted) {
                                    requestList?.removeAt(index);
                                    setState(() {});
                                  }
                                },
                                icon: const Icon(Icons.person_remove_outlined))
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
