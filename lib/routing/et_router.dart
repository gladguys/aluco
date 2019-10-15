import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ETRouter {
  static Future<dynamic> push(BuildContext context, Widget widget) async {
    _onBeforePush(widget);
    dynamic navigationValue = await Navigator.of(context).push(CupertinoPageRoute(builder: (_) => widget));
    _onAfterPush(widget);
    return navigationValue;
  }

  static void _onBeforePush(Widget widget) {
    print('------ Navigated to: ${widget.toString().toUpperCase()} ------');
  }

  static void _onAfterPush(Widget widget) {
    print('------ Navigated out of: ${widget.toString().toUpperCase()} ------');
  }
}