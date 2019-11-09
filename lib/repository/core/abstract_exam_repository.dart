import 'package:aluco/model/exam.dart';

abstract class AbstractExamRepository {
  Future<List<Exam>> getAll();
  Future<Exam> save(Exam exam);
  Future<void> delete(int id);
}