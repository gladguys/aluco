import 'package:aluco/model/class.dart';
import 'package:aluco/model/student.dart';

import 'abstract_repository.dart';

abstract class AbstractClassRepository extends AbstractRepository<Class> {
  Future<List<Student>> getStudentsByClass(int classId);
  Future<void> saveClassStudents(int classId, List<Student> students);
  Future<void> unlinkStudentFromClass(int classId, int studentId);
}