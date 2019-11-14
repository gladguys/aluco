import 'package:aluco/model/exam.dart';

import 'abstract_repository.dart';

abstract class AbstractExamRepository extends AbstractRepository<Exam> {
  Future<List<Exam>> getByClass(int classId);
}
