import 'dart:io';

import 'package:aluco/core/bloc/file_upload_bloc.dart';
import 'package:aluco/core/utils/pref_utils.dart';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
        File file = await ImagePicker.pickImage(source: ImageSource.camera);
        file = await rotateAndCompressAndSaveImage(file);

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

  Future<File> rotateAndCompressAndSaveImage(File image) async {
    int rotate = 0;
    final List<int> imageBytes = await image.readAsBytes();
    final Map<String, IfdTag> exifData = await readExifFromBytes(imageBytes);

    if (exifData != null &&
        exifData.isNotEmpty &&
        exifData.containsKey('Image Orientation')) {
      print(exifData);
      final IfdTag orientation = exifData['Image Orientation'];
      final int orientationValue = orientation.values[0];

      if (orientationValue == 3) {
        rotate = 180;
      }

      if (orientationValue == 6) {
        rotate = -90;
      }

      if (orientationValue == 0 || orientationValue == 8) {
        rotate = 90;
      }
    }

    final List<int> result = await FlutterImageCompress.compressWithList(
        imageBytes,
        quality: 100,
        rotate: rotate);

    await image.writeAsBytes(result);

    return image;
  }
}
