import 'package:aluco/enums/call_status.dart';
import 'package:aluco/model/class.dart';
import 'package:aluco/model/student.dart';
import 'package:aluco/model/student_call.dart';
import 'package:aluco/repository/api/API.dart';
import 'package:aluco/repository/api/call_service.dart';
import 'package:aluco/repository/api/class_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class CallBloc extends BlocBase {
  final dateController = BehaviorSubject<DateTime>.seeded(DateTime.now());
  final studentsCallController = BehaviorSubject<List<StudentCall>>.seeded([]);
  final _classRepository = ClassRepository(CLASS, Class());
  final _callService = CallService();
  final dateFormat = DateFormat('dd/MM/yyyy');

  Future<void> initializeClassStudents(int classId) async {
    final studentsCalls = <StudentCall>[];
    try {
      final date = dateFormat.format(DateTime.now());
      final callsOnDate =
          await _callService.getClassStudentsCallOnDate(classId, date);

      if (callsOnDate == null || callsOnDate.isEmpty) {
        final classStudents =
            await _classRepository.getStudentsByClass(classId);
        for (Student student in classStudents) {
          studentsCalls.add(
            StudentCall(
              classId: classId,
              date: date,
              status: CallStatus.PRESENTE,
              studentId: student.id,
            ),
          );
        }
      }

      studentsCallController.add(studentsCalls);
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<List<StudentCall>> getClassStudentsCallOnDate(
      int classId, String date) {
    return _callService.getClassStudentsCallOnDate(classId, date);
  }

  Future<void> handleStudentCallChanged(StudentCall student, int status) async {
    try {
      final studentsCalls = studentsCallController.value;
      final index =
          studentsCalls.indexWhere((studentCall) => studentCall == student);
      final copyStudent = studentsCalls[index];
      final newStudentCall = StudentCall(
          studentId: student.id,
          status: getCallStatusFromInt(status),
          date: copyStudent.date,
          classId: copyStudent.classId,
          id: copyStudent.id);
      studentsCalls.insert(index, newStudentCall);
      await _callService.changeStudentCall(newStudentCall);
      studentsCallController.add(studentsCalls);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    dateController.close();
    super.dispose();
  }
}
