import 'dart:io';

import 'package:aluco/repository/core/abstract_file_upload_repository.dart';
import 'package:aluco/repository/dio/dio_builder.dart';
import 'package:dio/dio.dart';

import 'API.dart';

class FileUploadRepository implements AbstractFileUploadRepository {
  final _dio = DioBuilder.getDio(isMultipartFile: true);

  Future<void> _uploadFile(
      {String path, File file, String param, String saveFilename}) async {
    try {
      final multipartFile =
          await MultipartFile.fromFile(file.path, filename: saveFilename);

      final formData = FormData.fromMap(<String, dynamic>{
        param: multipartFile,
      });

      await _dio.post<dynamic>(path, data: formData);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> uploadProfileFile({File file, String saveFilename}) async {
    try {
      await _uploadFile(
          path: PROFILES,
          file: file,
          param: 'photoProfile',
          saveFilename: saveFilename);
    } catch (e) {
      rethrow;
    }
  }
}
