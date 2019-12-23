import 'dart:io';

import 'package:aluco/core/bloc/file_upload_bloc.dart';
import 'package:aluco/core/utils/pref_utils.dart';
import 'package:aluco/repository/api/API.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:ok_image/ok_image.dart';

class ALInfoUserDialog extends StatefulWidget {
  @override
  _ALInfoUserDialogState createState() => _ALInfoUserDialogState();
}

class _ALInfoUserDialogState extends State<ALInfoUserDialog> {
  File _image;
  final _bloc = FileUploadBloc();

  @override
  Widget build(BuildContext context) {
    return NAlertDialog(
      dialogStyle: DialogStyle(
        borderRadius: BorderRadius.circular(24),
        contentPadding: const EdgeInsets.all(16),
      ),
      blur: 3,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              final file =
                  await ImagePicker.pickImage(source: ImageSource.camera);
              setState(() {
                _image = file;
              });
              final teacherId = PrefUtils.getTeacherId();
              await _bloc.uploadProfileFile(
                  file: _image, saveFilename: '$teacherId.jpg');
            },
            child: _getImage(),
          ),
          const SizedBox(height: 16),
          const Text(
            'Osvaldo Lourenço Filho',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'cristianoosvaldo@fortalezaec.com',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 32),
          OutlineButton(
            child: const Text('SAIR'),
            color: Colors.red[600],
            textColor: Colors.red[600],
            borderSide: BorderSide(color: Colors.red[200]),
            highlightedBorderColor: Colors.red[300],
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget _getImage() {
    if (_image != null) {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: FileImage(_image),
            fit: BoxFit.contain,
          ),
        ),
      );
    } else {
      final teacherId = PrefUtils.getTeacherId();
      return OKImage(
        url: '$AWS_FILE_BUCKET_URL/$teacherId..jpg',
        width: 120,
        height: 120,
        timeout: Duration(seconds: 20),
        fit: BoxFit.contain,
        errorWidget: (e) => Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: const AssetImage('assets/images/user120.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
    }
  }
}
