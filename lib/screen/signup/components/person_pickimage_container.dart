import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PersonPickImageContainer extends StatefulWidget {
  const PersonPickImageContainer({this.onPickImage});

  final Function onPickImage;

  @override
  _PersonPickImageContainerState createState() =>
      _PersonPickImageContainerState();
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
      child: Material(
        elevation: 2,
        color: Colors.white.withAlpha(200),
        borderRadius: BorderRadius.circular(100),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: _pickedImage != null
              ? ImageContainer(_pickedImage)
              : IconContainer(),
        ),
      ),
    );
  }
}

class IconContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Icons.add_a_photo,
        size: 48.0,
        color: Theme.of(context).accentColor.withAlpha(200),
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer(this.image);

  final File image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundImage: FileImage(image),
    );
  }
}
