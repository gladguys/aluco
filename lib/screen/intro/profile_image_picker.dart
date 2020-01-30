import 'dart:io';

import 'package:aluco/core/bloc/file_upload_bloc.dart';
import 'package:aluco/core/utils/pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatefulWidget {
  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File _image;
  final _bloc = FileUploadBloc();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final file = await ImagePicker.pickImage(source: ImageSource.camera);
        setState(() {
          _image = file;
        });
        final teacherId = PrefUtils.getTeacherId();
        await _bloc.uploadProfileFile(
            file: _image, saveFilename: '$teacherId.jpg');
      },
      child: _image != null
          ? Image.file(_image)
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.camera_alt,
                  size: 120,
                  color: Colors.orange[600],
                ),
                const Text('Toque aqui para adicionar sua foto de perfil.')
              ],
            ),
    );
  }
}
