import 'package:aluco/model/exam.dart';
import 'package:aluco/model/exam_grade_dto.dart';
import 'package:aluco/model/grades_wrapper.dart';
import 'package:aluco/repository/api/API.dart';

import 'package:aluco/repository/core/abstract_exam_repository.dart';
import 'package:aluco/repository/core/base_repository.dart';
import 'package:aluco/repository/dio/dio_builder.dart';
import 'package:dio/dio.dart';

class ExamRepository extends BaseRepository<Exam>
    implements AbstractExamRepository {

  ExamRepository(String basePath, Exam instance) : super(basePath, instance);

  final _dio = DioBuilder.getDio();

  @override
  Future<void> saveExamGrades(
      int examId, List<ExamGradeDTO> studentsGrades) async {
    final wrapper = GradesWrapper(studentsGrades.map((studentsGrade) => studentsGrade..examId = examId).toList());
    await _dio.post<dynamic>('$EXAM/$examId/$GRADE', data: wrapper.toJson());
  }

  @override
  Future<List<ExamGradeDTO>> getGradesByExam(int examId) async {
    try {
      final Response response = await _dio.get<dynamic>('$EXAM/$examId/$GRADE');
      return List.generate(
        response.data.length,
            (i) => ExamGradeDTO.fromJson(response.data[i]),
      );
    } catch (e) {
      rethrow;
    }
  }

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
