import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatefulWidget {
  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final file = await ImagePicker.pickImage(source: ImageSource.camera);
        setState(() {
          _image = file;
        });
      },
      child: _image != null ? Image.file(_image) : Icon(
        Icons.person_pin,
        size: 80,
      ),
    );
  }
}
