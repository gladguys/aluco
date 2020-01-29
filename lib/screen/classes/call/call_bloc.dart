import 'package:aluco/core/locator/locator.dart';
import 'package:aluco/enums/call_status.dart';
import 'package:aluco/model/student.dart';
import 'package:aluco/model/student_absence.dart';
import 'package:aluco/model/student_call.dart';
import 'package:aluco/repository/api/call_repository.dart';
import 'package:aluco/repository/api/class_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class CallBloc extends BlocBase {
  final dateController = BehaviorSubject<DateTime>.seeded(DateTime.now());
  final studentsCallController = BehaviorSubject<List<StudentCall>>.seeded([]);
  final studentAbsencesControllers = <BehaviorSubject<StudentAbsence>>[];

  final _classRepository = G<ClassRepository>();
  final _callRepository = G<CallRepository>();
  final dateFormat = DateFormat('dd/MM/yyyy');

  BehaviorSubject<StudentAbsence> getStudentAbsence(int studentId) {
    return studentAbsencesControllers
        .firstWhere((controller) => controller.value.studentId == studentId);
  }

  Future<void> initializeClassStudentsFromDate(
      int classId, DateTime callDate) async {
    await initClassAbsences(classId);

    final studentsCalls = <StudentCall>[];
    try {
      final date = dateFormat.format(callDate);
      final callsOnDate =
          await _callRepository.getClassStudentsCallOnDate(classId, date);

      final classStudents = await _classRepository.getStudentsByClass(classId);

      if (callsOnDate == null || callsOnDate.isEmpty) {
        for (Student student in classStudents) {
          studentsCalls.add(
            StudentCall(
              classId: classId,
              studentName: student.name,
              date: date,
              status: CallStatus.NENHUMA,
              studentId: student.id,
            ),
          );
        }
      } else {
        studentsCalls.addAll(callsOnDate);
        final studentCallIds =
            studentsCalls.map((studentCall) => studentCall.studentId).toList();
        final studentsWithNoCall = classStudents
            .where((classStudent) => !studentCallIds.contains(classStudent.id));
        for (Student student in studentsWithNoCall) {
          studentsCalls.add(
            StudentCall(
              classId: classId,
              studentName: student.name,
              date: date,
              status: CallStatus.NENHUMA,
              studentId: student.id,
            ),
          );
        }
      }
      studentsCallController.value = studentsCalls;
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> initClassAbsences(int classId) async {
    final classStudents = await _classRepository.getStudentsByClass(classId);
    final absences = await _classRepository.getAbsences(classId);
    for (StudentAbsence studentAbsence in absences) {
      studentAbsencesControllers.add(BehaviorSubject.seeded(studentAbsence));
    }
    for (Student student in classStudents) {
      if (studentAbsencesControllers.indexWhere((studentAbsence) =>
              studentAbsence.value.studentId == student.id) ==
          -1) {
        studentAbsencesControllers.add(
          BehaviorSubject.seeded(
            StudentAbsence(
              qtAbsences: 0,
              studentId: student.id,
              classId: classId,
            ),
          ),
        );
      }
    }
  }

  Future<List<StudentCall>> getClassStudentsCallOnDate(
      int classId, String date) {
    return _callRepository.getClassStudentsCallOnDate(classId, date);
  }

  Future<void> sendDailyCall(int classId, String email) async {
    await _callRepository.sendDailyCalls(classId, email);
  }

  Future<void> handleStudentCallChanged(StudentCall student, int status) async {
    try {
      final studentsCalls = studentsCallController.value;
      final index =
          studentsCalls.indexWhere((studentCall) => studentCall == student);

      final studentAbsenceController = getStudentAbsence(student.studentId);
      final studentAbsence = studentAbsenceController.value;
      if ((student.status == CallStatus.NENHUMA ||
              student.status == CallStatus.PRESENTE ||
              student.status == CallStatus.FALTA_JUSTIFICADA) &&
          status == 1) {
        studentAbsence.qtAbsences = studentAbsence.qtAbsences + 1;
      } else if (student.status == CallStatus.FALTA && status != 1) {
        studentAbsence.qtAbsences = studentAbsence.qtAbsences - 1;
      }
      studentAbsenceController.add(studentAbsence);

      studentsCalls[index].status = getCallStatusFromInt(status);

      final returnedStudent =
          await _callRepository.changeStudentCall(studentsCalls[index]);
      studentsCalls[index].id = returnedStudent.id;
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
