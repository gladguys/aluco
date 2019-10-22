import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ALRouter {
  static Future<dynamic> push(BuildContext context, Widget widget) async {
    _onBeforePush(widget);
    final dynamic navigationValue = await Navigator.of(context)
        .push<dynamic>(CupertinoPageRoute<dynamic>(builder: (_) => widget));
    _onAfterPush(widget);
    return navigationValue;
  }

  static Future<dynamic> pushAndReplace(
      BuildContext context, Widget widget) async {
    _onBeforePush(widget);
    final dynamic navigationValue = await Navigator.of(context)
        .pushReplacement<dynamic, dynamic>(
            CupertinoPageRoute<dynamic>(builder: (_) => widget));
    _onAfterPush(widget);
    return navigationValue;
  }

  static void pop<T extends Object>(BuildContext context, [dynamic value]) {
    Navigator.of(context).pop<T>(value);
  }

  static void _onBeforePush(Widget widget, [bool replace = false]) {
    print('------ ${replace ? 'Pop the top and' : ''} Navigated to: ${widget.toString()} ------');
  }

  static void _onAfterPush(Widget widget) {
    print('------ Navigated out of: ${widget.toString()} ------');
  }
}
