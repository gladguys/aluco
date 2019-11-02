import 'package:flutter/material.dart';

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
        title: titleWidget ?? Text(title),
        actions: actions,
        elevation: 0.5,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
