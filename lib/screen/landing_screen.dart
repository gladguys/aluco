import 'package:aluco/core/routing/al_router.dart';
import 'package:aluco/core/utils/jwt_utils.dart';
import 'package:flutter/material.dart';

import 'home/home_screen.dart';
import 'signin/signin_screen.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  @override
  void initState() {
    if (JWTUtils.userAlreadySignedIn()) {
      ALRouter.pushAndReplace(context, HomeScreen());
    } else {
      ALRouter.pushAndReplace(context, SigninScreen());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
