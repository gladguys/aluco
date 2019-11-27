import 'dart:io';

import 'package:aluco/repository/api/file_upload_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class FileUploadBloc extends BlocBase {

  final _repository = FileUploadRepository();

  Future<void> uploadProfileFile({File file, String saveFilename}) async {
    try {
      await _repository.uploadProfileFile(file: file, saveFilename: saveFilename);
    } catch (e) {
      print(e);
      throw Exception();
    }
  }
}