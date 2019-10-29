import 'package:aluco/model/student.dart';

abstract class AbstractStudentRepository {
  Future<List<Student>> getAll();
  Future<void> save(Student student);
  Future<void> delete(int id);
}