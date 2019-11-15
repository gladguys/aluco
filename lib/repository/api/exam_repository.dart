import 'package:aluco/model/exam.dart';

import 'package:aluco/repository/core/abstract_exam_repository.dart';
import 'package:aluco/repository/core/base_repository.dart';
import 'package:aluco/repository/dio/dio_builder.dart';

class ExamRepository extends BaseRepository<Exam>
    implements AbstractExamRepository {
  ExamRepository(String basePath, Exam instance) : super(basePath, instance);

  final _dio = DioBuilder.getDio();

  @override
  Future<List<Exam>> getByClass(int classId) async {
    try {
      final response = await _dio.get<dynamic>(basePath, queryParameters: <String, dynamic>{
        'classId': classId.toString()
      });
      return List.generate(
        response.data.length,
        (i) {
          final exam = Exam();
          return exam.fromJson(response.data[i]);
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
