import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'al_debug_http_button.dart';

class ALScaffold extends StatelessWidget {
  const ALScaffold({
    this.title,
    this.titleWidget,
    this.subtitle,
    this.actions,
    this.floatingActionButton,
    @required this.body,
  })  : assert(title != null || titleWidget != null),
        assert(body != null);

  final String title;
  final Widget titleWidget;
  final String subtitle;
  final List<Widget> actions;
  final Widget body;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        title: titleWidget ??
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: -0.4,
              ),
            ),
        bottom: subtitle != null
            ? PreferredSize(
                preferredSize: const Size(300, 16),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
                  child: Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            : null,
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
    return [...actions ?? [], ALDebugHttpButton()];
  }
}