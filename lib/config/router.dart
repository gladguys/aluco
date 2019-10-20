import 'package:flutter/material.dart';
import 'package:simple_router/simple_router.dart';

void setupRouter() {
  SimpleRouter.onBeforePush = onBeforePush;
  SimpleRouter.onAfterPush = onAfterPush;
}

Function(Widget) onBeforePush = (Widget w) =>
    print('------------ Navigated to: ${w.toString()} ------------');

Function(Widget) onAfterPush = (Widget w) =>
    print('------------ Navigated back from: ${w.toString()} ------------');