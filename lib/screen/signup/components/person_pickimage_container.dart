import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PersonPickImageContainer extends StatefulWidget {
  PersonPickImageContainer({this.onPickImage});

  final Function onPickImage;

  @override
  _PersonPickImageContainerState createState() => _PersonPickImageContainerState();
}

class _PersonPickImageContainerState extends State<PersonPickImageContainer> {
  File _pickedImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _pickedImage = await ImagePicker.pickImage(source: ImageSource.camera);
        if (_pickedImage != null) {
          setState(() => widget.onPickImage(_pickedImage.path));
        }
      },
      child: _pickedImage != null ? ImageContainer(_pickedImage) : IconContainer()
    );
  }
}

class IconContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(Icons.person, size: 60),
    );
  }
}

class ImageContainer extends StatelessWidget {
  ImageContainer(this.image);

  final File image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundImage: FileImage(image),
    );
  }
}