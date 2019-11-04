import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../main.dart';

class ALDebugHttpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 40,
      icon: Icon(MaterialIcons.getIconData('http')),
      onPressed: () => alice.showInspector(),
    );
  }
}