import 'package:aluco/core/routing/al_router.dart';
import 'package:flutter/material.dart';

class HaveAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        'Já tenho uma conta!',
        style: TextStyle(
          color: Theme.of(context).accentColor,
          fontSize: 16.0,
        ),
      ),
      onPressed: () => ALRouter.pop(context),
    );
  }
}
