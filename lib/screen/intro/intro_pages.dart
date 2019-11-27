import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'profile_image_picker.dart';

final initialPage = PageViewModel(
  decoration: PageDecoration(
      pageColor: Colors.grey[100]
  ),
  title: '',
  bodyWidget: const Text('Aluco é um aplicativo blah blah blah pra fazer bluh blub bluh com os cru cru cru'),
  image: Image.asset('assets/images/owl.png'),
);

final profilePhotoPage = PageViewModel(
  titleWidget: const SizedBox(height: 120),
  bodyWidget: Column(
    children: <Widget>[
      ProfileImagePicker(),
      const SizedBox(height: 80),
      const Text('Você deseja adicionar uma foto sua? Adicionar uma foto sua pode tornar a experiência de uso mais pessoal.'),
    ],
  ),
);

final helperPage = PageViewModel(
  title: 'Title of first page',
  bodyWidget: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Icon(Icons.edit),
    ],
  ),
  image: const Center(child: Icon(Icons.android)),
);

final pages = [
  initialPage,
  profilePhotoPage,
  helperPage
];