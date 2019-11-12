import 'package:aluco/model/class.dart';
import 'package:aluco/model/exam.dart';
import 'package:aluco/model/student.dart';
import 'package:aluco/model/student_grade.dart';
import 'package:aluco/repository/api/API.dart';
import 'package:aluco/repository/api/class_repository.dart';
import 'package:aluco/repository/api/exam_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class ExamBloc extends BlocBase {
  final _repository = ExamRepository(EXAM, Exam());
  final _classRepository = ClassRepository(CLASS, Class());
  final _examsController = BehaviorSubject<List<Exam>>();
  final _pickedExamController = BehaviorSubject<Exam>.seeded(null);

  Stream<List<Exam>> get examStream => _examsController.stream;
  List<Exam> get examsList => _examsController.value;

  Exam get pickedExam => _pickedExamController.value;

  final _studentsGradesController =
      BehaviorSubject<List<StudentGrade>>.seeded([]);
  Stream<List<StudentGrade>> get studentsGradesStream =>
      _studentsGradesController.stream;
  List<StudentGrade> get studentsGradesList => _studentsGradesController.value;

  Future<void> getAll() async {
    try {
      _examsController.add(await _repository.getAll());
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> save(Exam exam, int classId) async {
    try {
      exam.classId = classId;
      final examSaved = await _repository.save(exam);
      if (exam.id == null) {
        examsList.add(examSaved);
        _examsController.add(examsList);
      } else {
        examsList.remove(exam);
        examsList.add(examSaved);
        _examsController.add(examsList);
      }
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> delete(Exam exam) async {
    try {
      await _repository.delete(exam.id);
      examsList.remove(exam);
      _examsController.add(examsList);
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<List<Student>> getStudentsByClass(int classId) async {
    try {
      return await _classRepository.getStudentsByClass(classId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> initStudentsGrades(int classId, int examId) async {
    try {
      final students = await _classRepository.getStudentsByClass(classId);
      final studentsGrades = List.generate(students.length,
          (i) => StudentGrade.fromStudentAndExam(students[i], examId));
      _studentsGradesController.add(studentsGrades);
    } catch (e) {
      rethrow;
    }
  }

  void cleanStudentesGrades() {
    _studentsGradesController.add([]);
  }

  void pickExam(Exam exam) {
    _pickedExamController.add(exam);
  }

  Future<void> saveInitialGrades(int examId) async {
    _repository.saveInitialGrades(examId, studentsGradesList);
  }

  void updateStudentGrade(int studentId, String grade) {
    final studentIndex = studentsGradesList.indexWhere((student) => student.studentId == studentId);
    print(studentIndex);
    if (studentIndex != -1) {
      final student = studentsGradesList[studentIndex];
      print(grade);
      student.grade = (grade != null && grade != '') ? double.parse(grade) : null;
      studentsGradesList.removeAt(studentIndex);
      print(student);
      studentsGradesList.add(student);
      _studentsGradesController.add(studentsGradesList);
    }
  }
}
