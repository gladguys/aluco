import 'package:flutter/material.dart';
import 'package:simple_router/simple_router.dart';

class HaveAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Spacer(flex: 1),
        Expanded(
          flex: 3,
          child: FlatButton(
            onPressed: () => SimpleRouter.back(),
            padding: const EdgeInsets.all(14),
            child: Text(
              'Já tenho uma conta!',
              style: TextStyle(color: Colors.green, fontSize: 18),
            ),
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
