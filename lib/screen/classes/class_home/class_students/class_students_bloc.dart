import 'package:aluco/model/student.dart';
import 'package:aluco/model/student_marked.dart';
import 'package:aluco/repository/api/class_repository.dart';
import 'package:aluco/repository/api/student_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class ClassStudentsBloc extends BlocBase {
  final allStudentsController = BehaviorSubject<List<Student>>.seeded([]);
  List<Student> get allStudents => allStudentsController.value;

  final allStudentsMarkedController =
      BehaviorSubject<List<StudentMarked>>.seeded([]);
  List<StudentMarked> get allStudentsMarked => allStudentsMarkedController.value;

  final allStudentsMarkedListController = <BehaviorSubject<StudentMarked>>[];

  final studentsToAddController = BehaviorSubject<List<Student>>.seeded([]);
  List<Student> get studentsToAdd => studentsToAddController.value;

  final studentsInClassController = BehaviorSubject<List<Student>>.seeded([]);
  List<Student> get studentsInClass => studentsInClassController.value;

  final studentsNotInClassController = BehaviorSubject<List<Student>>.seeded([]);
  List<Student> get studentsNotInClass => studentsNotInClassController.value;

  int classId;
  final _classRepository = ClassRepository();
  final _studentRepository = StudentRepository();

  Future<void> initStudents(int classId) async {
    this.classId = classId;
    allStudents.addAll(await _studentRepository.getAll());
    studentsInClass.addAll(await _classRepository.getStudents(classId));
    studentsNotInClass.addAll([...allStudents]..removeWhere((student) =>
        studentsInClass.indexWhere((s) => s.id == student.id) != -1));

    allStudentsController.add(allStudents);
    studentsInClassController.add(studentsInClass);
    studentsNotInClassController.add(studentsNotInClass);
    markAllNotInCLassStudents();
  }

  void markAllNotInCLassStudents() {
    final studentsNotInClass = studentsNotInClassController.value;
    final markedStudents = studentsNotInClass
        .map((student) => StudentMarked(student: student))
        .toList();

    allStudentsMarkedController.add(markedStudents);
    for (StudentMarked markedStudent in markedStudents) {
      allStudentsMarkedListController
          .add(BehaviorSubject<StudentMarked>()..add(markedStudent));
    }
  }

  void markStudent(Student student, bool marked) {
    final allStudentsMarked = allStudentsMarkedController.value;
    final studentsInClass = studentsInClassController.value;
    final index = allStudentsMarked
        .indexWhere((markedStudent) => markedStudent.student.id == student.id);
    if (index != -1) {
      allStudentsMarked[index].marked = marked;

      allStudentsMarkedListController[index].add(allStudentsMarked[index]);

      if (marked) {
        studentsToAdd.add(student);
        studentsNotInClass.removeWhere(
            (notInClassStudent) => notInClassStudent.id == student.id);
      } else {
        studentsToAdd
            .removeWhere((studentsInClass) => studentsInClass.id == student.id);
        studentsNotInClass.add(student);
      }
    }
    studentsInClassController.add(studentsInClass);
    studentsNotInClassController.add(studentsNotInClass);
    allStudentsMarkedController.add(allStudentsMarked);
  }

  Future<void> saveNewStudents() async {
    try {
      await _classRepository.saveStudents(classId, studentsToAdd);
      studentsInClass.addAll(studentsToAdd);
      studentsInClassController.add(studentsInClass);
      allStudentsMarked.removeWhere((sm) => studentsToAdd.contains(sm.student));
      allStudentsMarkedController.add(allStudentsMarked);
      studentsToAdd.clear();
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  void cleanBloc() {
    allStudentsController.add([]);
    allStudentsMarkedController.add([]);
    studentsToAddController.add([]);
    studentsInClassController.add([]);
    studentsNotInClassController.add([]);
  }
}
