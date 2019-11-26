import 'package:aluco/core/routing/al_router.dart';
import 'package:aluco/core/utils/jwt_utils.dart';
import 'package:aluco/screen/signin/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ALLogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await JWTUtils.clearUserInfo();
        await Navigator.of(context).pushAndRemoveUntil<dynamic>(
            MaterialPageRoute<dynamic>(
              builder: (_) => SigninScreen(),
            ),
            (route) => false);

        ALRouter.push(context, SigninScreen());
      },
      child: Icon(MaterialCommunityIcons.getIconData('exit-run'), size: 32),
    );
  }
}
