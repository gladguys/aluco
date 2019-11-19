import 'package:aluco/model/class.dart';
import 'package:aluco/model/exam.dart';
import 'package:aluco/model/exam_grade_dto.dart';
import 'package:aluco/model/student.dart';
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

  final _studentsGradesController = BehaviorSubject<List<ExamGradeDTO>>();
  Stream<List<ExamGradeDTO>> get studentsGradesStream =>
      _studentsGradesController.stream;
  List<ExamGradeDTO> get studentsGradesList => _studentsGradesController.value;

  Future<void> getAll() async {
    try {
      _examsController.add(await _repository.getAll());
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> getExamsByClass(int classId) async {
    try {
      _examsController.add(await _repository.getByClass(classId));
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

  Future<void> getGradesByExam(int examId) async {
    try {
      final examGrades = await _repository.getGradesByExam(examId);
      _studentsGradesController.add(examGrades);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveExamGrades() async {
    try {
      await _repository.saveExamGrades(pickedExam.id, studentsGradesList);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateGrade(ExamGradeDTO examGrade, double grade) async {
    try {
      final index = studentsGradesList.indexWhere((exam) => exam == examGrade);
      if (index != -1) {
        studentsGradesList[index].grade = grade;
        _studentsGradesController.add(studentsGradesList);
      }
    } catch (e) {
      rethrow;
    }
  }

  void cleanStudentesGrades() {
    _studentsGradesController.add(null);
  }

  void pickExam(Exam exam) {
    _pickedExamController.add(exam);
  }
}
