import 'package:aluco/model/class.dart';
import 'package:aluco/model/class_config.dart';
import 'package:aluco/model/student.dart';
import 'package:aluco/model/student_absence.dart';
import 'package:aluco/model/student_grades.dart';

import 'abstract_repository.dart';

abstract class AbstractClassRepository extends AbstractRepository<Class> {
  Future<List<Class>> getAllClassesByTeacher(int teacherId);
  Future<List<Student>> getStudentsByClass(int classId);
  Future<void> saveClassStudents(int classId, List<Student> students);
  Future<void> saveClassConfig(int classId, Class classe);
  Future<ClassConfig> getClassConfig(int classId);
  Future<void> unlinkStudentFromClass(int classId, int studentId);
  Future<List<StudentGrades>> getGradesBoard(int classId);
  Future<List<StudentAbsence>> getAbsences(int classId);
}
