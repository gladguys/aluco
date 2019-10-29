import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gg_flutter_components/container/gg_icon_container.dart';
import 'package:gg_flutter_components/container/gg_image_container.dart';

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
            ? GGImageContainer(image: _pickedImage)
            : GGIconContainer(),
        ),
      ),
    );
  }
}
