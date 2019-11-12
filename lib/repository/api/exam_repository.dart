import 'package:aluco/model/exam.dart';
import 'package:aluco/model/grades_wrapper.dart';
import 'package:aluco/model/student_grade.dart';

import 'package:aluco/repository/api/API.dart';
import 'package:aluco/repository/core/abstract_exam_repository.dart';
import 'package:aluco/repository/core/base_repository.dart';
import 'package:aluco/repository/dio/dio_builder.dart';

class ExamRepository extends BaseRepository<Exam>
    implements AbstractExamRepository {
  final _dio = DioBuilder.getDio();

  ExamRepository(String basePath, Exam instance) : super(basePath, instance);

  Future<void> saveInitialGrades(int examId, List<StudentGrade> studentsGrades) async {
    final wrapper = GradesWrapper(studentsGrades);
    await _dio.post<dynamic>('$EXAM/$examId/$GRADE', data: wrapper.toJson());
  }
}
