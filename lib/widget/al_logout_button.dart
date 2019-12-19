import 'package:aluco/core/utils/jwt_utils.dart';
import 'package:aluco/screen/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ALLogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 40,
      icon: Icon(Icons.exit_to_app),
      onPressed: () async {
        await JWTUtils.clearInfo();
        Get.offAll(LandingScreen(), (r) => false);
      },
    );
  }
}
