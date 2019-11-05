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
      final studentSaved = await _repository.save(student);
      if (student.id == null) {
        studentList.add(studentSaved);
        _studentsController.add(studentList);
      } else {
        studentList.remove(student);
        studentList.add(studentSaved);
        _studentsController.add(studentList);
      }
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> delete(Student student) async {
    try {
      await _repository.delete(student.id);
      studentList.remove(student);
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