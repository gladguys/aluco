import 'package:aluco/model/student.dart';
import 'package:aluco/model/student_call_entry.dart';
import 'package:aluco/repository/api/API.dart';
import 'package:aluco/repository/api/student_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class CallBloc extends BlocBase {
  final dateController = BehaviorSubject<DateTime>.seeded(DateTime.now());
  final classStudentsController = BehaviorSubject<List<Student>>.seeded([]);
  final studentsCallController =
      BehaviorSubject<List<StudentCallEntry>>.seeded([]);
  final _studentRepository = StudentRepository(STUDENT, Student());
  final dateFormat = DateFormat('dd/MM/yyyy');

  Future<void> initializeClassStudents() async {
    final studentsCalls = <StudentCallEntry>[];
    try {
      classStudentsController.add(await _studentRepository.getAll());

      for (Student student in classStudentsController.value) {
        studentsCalls.add(StudentCallEntry(student, 0));
      }
      studentsCallController.add(studentsCalls);
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  void handleStudentCallChanged(Student student, int status) {
    final studentsCalls = studentsCallController.value;
    final index = studentsCalls
        .indexWhere((studentCall) => studentCall.student == student);
    studentsCalls.insert(index, StudentCallEntry(student, status));
    studentsCallController.add(studentsCalls);
  }

  Future<void> saveCallDay() async {}

  @override
  void dispose() {
    dateController.close();
    super.dispose();
  }
}
