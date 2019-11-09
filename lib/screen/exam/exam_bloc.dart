import 'package:aluco/model/exam.dart';
import 'package:aluco/repository/api/exam_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class ExamBloc extends BlocBase {
  final _repository = ExamRepository();
  final _examsController = BehaviorSubject<List<Exam>>();

  Stream<List<Exam>> get examStream => _examsController.stream;
  List<Exam> get examsList => _examsController.value;

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
}