import 'package:aluco/core/routing/al_router.dart';
import 'package:aluco/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'intro_pages.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: pages,
      showSkipButton: true,
      skip: const Text('Skip'),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () async {
        ALRouter.pushAndReplace(context, HomeScreen());
      },
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: Theme.of(context).primaryColor,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
