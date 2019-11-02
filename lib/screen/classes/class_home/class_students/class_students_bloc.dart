import 'package:aluco/model/student.dart';
import 'package:aluco/model/student_marked.dart';
import 'package:aluco/repository/api/class_repository.dart';
import 'package:aluco/repository/api/student_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class ClassStudentsBloc extends BlocBase {
  
  final allStudentsStream = BehaviorSubject<List<Student>>.seeded([]);
  List<Student> get allStudents => allStudentsStream.value;

  final allStudentsMarkedStream = BehaviorSubject<List<StudentMarked>>.seeded([]);
  List<StudentMarked> get allStudentsMarked => allStudentsMarkedStream.value;

  final studentsToAddStream = BehaviorSubject<List<Student>>.seeded([]);
  List<Student> get studentsToAdd => studentsToAddStream.value;

  final studentsInClassStream = BehaviorSubject<List<Student>>.seeded([]);
  List<Student> get studentsInClass => studentsInClassStream.value;

  final studentsNotInClassStream = BehaviorSubject<List<Student>>.seeded([]);
  List<Student> get studentsNotInClass => studentsNotInClassStream.value;

  int classId;
  final _classRepository = ClassRepository();
  final _studentRepository = StudentRepository();

  Future<void> initStudents(int classId) async {
    this.classId = classId;
    allStudents.addAll(await _studentRepository.getAll());
    studentsInClass.addAll(await _classRepository.getStudents(classId));
    studentsNotInClass.addAll([...allStudents]
      ..removeWhere((student) => studentsInClass.indexWhere((s) => s.id == student.id) != -1));

    allStudentsStream.add(allStudents);
    studentsInClassStream.add(studentsInClass);
    studentsNotInClassStream.add(studentsNotInClass);
    markAllNotInCLassStudents();
  }

  void markAllNotInCLassStudents() {
    final studentsNotInClass = studentsNotInClassStream.value;
    final markedStudents = studentsNotInClass
        .map((student) => StudentMarked(student: student))
        .toList();

    allStudentsMarkedStream.add(markedStudents);
  }

  void markStudent(Student student, bool marked) {
    final allStudentsMarked = allStudentsMarkedStream.value;
    final studentsInClass = studentsInClassStream.value;
    final index = allStudentsMarked.indexWhere((markedStudent) => markedStudent.student.id == student.id);
    if (index != -1) {
      allStudentsMarked[index].marked = marked;

      if (marked) {
        studentsToAdd.add(student);
        studentsNotInClass.removeWhere((notInClassStudent) => notInClassStudent.id == student.id);
      } else {
        studentsToAdd.removeWhere((studentsInClass) => studentsInClass.id == student.id);
        studentsNotInClass.add(student);
      }
    }
    studentsInClassStream.add(studentsInClass);
    studentsNotInClassStream.add(studentsNotInClass);
    allStudentsMarkedStream.add(allStudentsMarked);
  }

  Future<void> saveNewStudents() async {
    try {
      await _classRepository.saveStudents(classId, studentsToAdd);
      studentsInClass.addAll(studentsToAdd);
      studentsInClassStream.add(studentsInClass);
      allStudentsMarked.removeWhere((sm) => studentsToAdd.contains(sm.student));
      allStudentsMarkedStream.add(allStudentsMarked);
      _studentRepository.isListStudentsDirty = true;
      
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  void cleanBloc() {
    allStudentsStream.add([]);
    allStudentsMarkedStream.add([]);
    studentsToAddStream.add([]);
    studentsInClassStream.add([]);
    studentsNotInClassStream.add([]);
  }
}
