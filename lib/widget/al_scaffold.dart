import 'package:flutter/material.dart';

class ALScaffold extends StatelessWidget {
  const ALScaffold({
    this.title,
    this.actions,
    @required this.body,
  }) : assert(body != null);

  final String title;
  final List<Widget> actions;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(color: const Color(0xFF389952), fontSize: 28),
        ),
        actions: actions,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: body,
    );
  }
}
