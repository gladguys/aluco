import 'package:aluco/widget/al_info_user_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/dialog/gg_dialog.dart';

class ProfileAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      margin: const EdgeInsets.only(left: 4, right: 12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: const AssetImage('assets/images/user.png'),
          fit: BoxFit.contain,
        ),
      ),
      child: FlatButton(
        padding: const EdgeInsets.all(0),
        shape: CircleBorder(),
        highlightColor: Colors.white10,
        splashColor: Colors.white30,
        onPressed: () {
          GGDialog.show(
            context,
            ALInfoUserDialog(),
          );
        },
        child: null,
      ),
    );
  }
}
