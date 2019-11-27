import 'dart:io';

abstract class AbstractFileUploadRepository {
  Future<void> uploadProfileFile({File file, String saveFilename});
}