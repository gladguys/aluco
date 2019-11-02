import 'package:aluco/model/student.dart';
import 'package:aluco/repository/api/student_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class StudentBloc extends BlocBase {
  final _repository = StudentRepository();
  final _studentsController = BehaviorSubject<List<Student>>.seeded([]);

  Stream<List<Student>> get studentStream => _studentsController.stream;
  List<Student> get studentList => _studentsController.value;

  Future<void> getAll() async {
    try {
      _studentsController.add(await _repository.getAll());
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> save(Student student) async {
    try {
      await _repository.save(student);
      if (student.id == null) {
        studentList.add(student);
        _studentsController.add(studentList);
      } else {
        studentList.removeWhere((s) => s.id == student.id);
        studentList.add(student);
        _studentsController.add(studentList);
        _repository.isListStudentsDirty = true;
      }
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> delete(int id) async {
    try {
      await _repository.delete(id);
      studentList.removeWhere((student) => student.id == id);
      _studentsController.add(studentList);
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  @override
  void dispose() {
    _studentsController.close();
    super.dispose();
  }
}