import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';
import 'package:simple_router/simple_router.dart';

class HaveAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Spacer(flex: 1),
        Expanded(
          flex: 3,
          child: FlatButton(
            onPressed: () => SimpleRouter.back(),
            padding: EdgeInsets.all(14),
            child: Text(
              'Já tenho uma conta!',
              style: TextStyle(color: Colors.green, fontSize: 18),
            ),
          ),
        ),
        Spacer(flex: 1),
      ],
    );
  }
}
