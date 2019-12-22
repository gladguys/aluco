import 'package:aluco/model/student_call.dart';

abstract class AbstractCallRepository {
  Future<List<StudentCall>> getClassStudentsCallOnDate(
      int classId, String date);
  Future<void> changeStudentCall(StudentCall studentCall);
}
