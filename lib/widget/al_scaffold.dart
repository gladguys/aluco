import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../main.dart';

class ALScaffold extends StatelessWidget {
  const ALScaffold({
    this.title,
    this.titleWidget,
    this.actions,
    this.floatingActionButton,
    @required this.body,
  })  : assert(title != null || titleWidget != null),
        assert(body != null);

  final String title;
  final Widget titleWidget;
  final List<Widget> actions;
  final Widget body;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        actions: _getActions(),
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }

  List<Widget> _getActions() {
    if (kReleaseMode) {
      return actions;
    }
    return [...actions ?? [], DebugHttpButton()];
  }
}

class DebugHttpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 40,
      icon: Icon(MaterialIcons.getIconData('http')),
      onPressed: () => alice.showInspector(),
    );
  }
}
