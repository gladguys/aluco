import 'dart:io';

import 'package:aluco/core/locator/locator.dart';
import 'package:aluco/core/utils/pref_utils.dart';
import 'package:aluco/repository/api/API.dart';
import 'package:aluco/repository/api/file_upload_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class FileUploadBloc extends BlocBase {
  final _repository = G<FileUploadRepository>();

  Future<void> uploadProfileFile({File file, String saveFilename}) async {
    try {
      await _repository.uploadProfileFile(
          file: file, saveFilename: saveFilename);

      await PrefUtils.setPhotoUrl('$S3_BUCKET/$saveFilename');
    } catch (e) {
      throw Exception();
    }
  }
}
