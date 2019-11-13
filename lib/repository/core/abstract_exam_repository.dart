import 'package:aluco/model/exam.dart';
import 'package:aluco/model/exam_grade_dto.dart';

import 'abstract_repository.dart';

abstract class AbstractExamRepository extends AbstractRepository<Exam> {
  Future<void> saveExamGrades(int examId, List<ExamGradeDTO> studentsGrades);
  Future<List<ExamGradeDTO>> getGradesByExam(int examId);
}
