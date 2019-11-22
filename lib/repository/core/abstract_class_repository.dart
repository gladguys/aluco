import 'package:aluco/model/class.dart';
import 'package:aluco/model/student.dart';
import 'package:aluco/model/student_grades.dart';

import 'abstract_repository.dart';

abstract class AbstractClassRepository extends AbstractRepository<Class> {
  Future<List<Student>> getStudentsByClass(int classId);
  Future<void> saveClassStudents(int classId, List<Student> students);
  Future<void> unlinkStudentFromClass(int classId, int studentId);
  Future<List<StudentGrades>> getGradesBoard(int classId);
}