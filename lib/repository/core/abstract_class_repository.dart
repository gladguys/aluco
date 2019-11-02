import 'package:aluco/model/class.dart';
import 'package:aluco/model/student.dart';

abstract class AbstractClassRepository {
  Future<List<Class>> getAll();
  Future<List<Student>> getStudents(int classId);
  Future<void> save(Class classe);
  Future<void> saveStudents(int classId, List<Student> students);
  Future<void> delete(int id);
}