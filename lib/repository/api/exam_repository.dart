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
  final _dio = DioBuilder.getDio();

  ExamRepository(String basePath, Exam instance) : super(basePath, instance);

  @override
  Future<void> saveExamGrades(
      int examId, List<ExamGradeDTO> studentsGrades) async {
    final wrapper = GradesWrapper(studentsGrades.map((studentsGrade) => studentsGrade..examId = examId).toList());
    await _dio.post<dynamic>('$EXAM/$examId/$GRADE', data: wrapper.toJson());
  }

  @override
  Future<List<ExamGradeDTO>> getGradesByExam(int examId) async {
    final Response response = await _dio.get<dynamic>('$EXAM/$examId/$GRADE');
    return List.generate(
      response.data.length,
      (i) => ExamGradeDTO.fromJson(response.data[i]),
    );
  }
}
