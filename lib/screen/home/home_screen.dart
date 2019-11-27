import 'dart:io';

import 'package:aluco/core/utils/jwt_utils.dart';
import 'package:aluco/repository/dio/dio_builder.dart';
import 'package:aluco/widget/al_logo.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';
import 'components/home.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File _image;
  final _dio = DioBuilder.getDio();

  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      titleWidget: ALLogo(
        color: Theme.of(context).primaryColor,
        fontSize: 40,
        hasShadow: false,
      ),
      actions: kReleaseMode ? <Widget>[
        Image.asset(
          'assets/images/user.png',
          fit: BoxFit.scaleDown,
          width: 34,
        ),
        const SizedBox(width: 12.0),
      ] : null,
      body: Column(
        children: <Widget>[
          Home(),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton.icon(onPressed: () async {
                final file = await ImagePicker.pickImage(source: ImageSource.camera);
                setState(() {
                  _image = file;
                });
              }, icon: Icon(Icons.image), label: const Text('Image')),
              const SizedBox(width: 15),
              RaisedButton.icon(onPressed: () async {
                if (_image != null) {
                  print(_image.path);
                  final formData = FormData.fromMap(<String, dynamic>{
                    'photoProfile':
                    await MultipartFile.fromFile(_image.path, filename: 'teste.png'),
                  });

                  Dio()
                      ..options.headers = <String, dynamic>{
                    'Content-Type': 'multipart/form-data'
                  }
                  ..options.headers = <String, dynamic>{
                    'Authorization': JWTUtils.getToken()
                  }
                  ..interceptors.add(alice.getDioInterceptor())
                  ..post<dynamic>(
                      'http://aluco-test.herokuapp.com/api/profiles',
                      data: formData);
                }
              }, icon: Icon(Icons.send), label: const Text('Send'))
            ],
          ),
          _image != null ? Image.file(_image) : const Text('Sem imagem'),
        ],
      ),
    );
  }
}
