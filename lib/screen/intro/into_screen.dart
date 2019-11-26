import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'profile_image_picker.dart';

class IntroScreen extends StatelessWidget {
  final listPages = [
    PageViewModel(
      title: "Title of first page",
      bodyWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Click on "),
          Icon(Icons.edit),
          Text(" to edit a post"),
        ],
      ),
      image: const Center(child: Icon(Icons.android)),
    ),
    PageViewModel(
      title: "Title of first page",
      bodyWidget: ProfileImagePicker(),
    ),
    PageViewModel(
      title: "Title of first page",
      bodyWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Click on "),
          Icon(Icons.edit),
          Text(" to edit a post"),
        ],
      ),
      image: const Center(child: Icon(Icons.android)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: listPages,
      showSkipButton: true,
      skip: const Text('Skip'),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () {
        print('a');
      },
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Theme.of(context).primaryColor,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0)
          )
      ),
    );
  }
}
