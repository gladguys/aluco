import 'package:flutter/material.dart';

class ALScaffold extends StatelessWidget {
  const ALScaffold({
    this.title,
    this.actions,
    this.floatingActionButton,
    @required this.body,
  }) : assert(body != null);

  final String title;
  final List<Widget> actions;
  final Widget body;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        actions: actions,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
