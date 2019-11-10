import 'package:aluco/model/exam.dart';

import 'package:aluco/repository/api/API.dart';
import 'package:aluco/repository/core/abstract_exam_repository.dart';
import 'package:aluco/repository/core/base_repository.dart';
import 'package:aluco/repository/dio/dio_builder.dart';
import 'package:dio/dio.dart';

class ExamRepository extends BaseRepository<Exam>
    implements AbstractExamRepository {
  ExamRepository(String basePath, Exam instance) : super(basePath, instance);
}
