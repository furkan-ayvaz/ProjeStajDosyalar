import 'package:flutter/material.dart';

import '../color/colors.dart';

class ProjectBorder {
  static final BoxBorder addFriendBoxBorder = Border.all(color: ProjectLightColor.darkColor, width: 3);
  static const BorderRadiusGeometry addFriendBoxRadius =
      BorderRadius.only(topRight: Radius.circular(50), bottomLeft: Radius.circular(50));
  static final BorderRadiusGeometry wordDetailBorderRadius = BorderRadius.circular(30);
  static const BorderRadius wordTextFieldBorderRadius = BorderRadius.all(Radius.circular(20));
}
