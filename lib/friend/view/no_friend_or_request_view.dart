import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/border/custom_border.dart';
import 'package:my_dictionary/constant/strings/strings.dart';

import '../../constant/color/colors.dart';

class NoFriendorRequestView extends StatelessWidget {
  final String? text;
  const NoFriendorRequestView({
    this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(
              color: ProjectLightColor.darkColor,
              borderRadius: ProjectBorder.addFriendBoxRadius,
            ),
            child: Text(
              text ?? ProjectStrings.nullText,
              style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),
            )));
  }
}
