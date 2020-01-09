import 'package:aluco/model/student_absence.dart';
import 'package:aluco/model/student_call.dart';
import 'package:aluco/model/student_grades.dart';

abstract class AbstractCallRepository {
  Future<List<StudentCall>> getClassStudentsCallOnDate(
      int classId, String date);
  Future<StudentCall> changeStudentCall(StudentCall studentCall);
  Future<List<StudentCall>> getStudentCalls(int studentId, int classId);
  Future<StudentAbsence> getStudentAbsences(int studentId, int classId);
  Future<StudentGrades> getStudentGrades(int studentId, int classId);
}
