import 'package:aluco/model/student.dart';
import 'package:aluco/repository/student_repository.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class StudentBloc extends Bloc {
  final _repository = StudentRepository();
  final _studentsController = BehaviorSubject<List<Student>>.seeded([]);

  Stream<List<Student>> get studentStream => _studentsController.stream;
  List<Student> get studentList => _studentsController.value;

  Future<void> getAllStudents() async {
    try {
      _studentsController.add(await _repository.getAllStudents());
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> saveStudent(Student student) async {
    try {
      return await _repository.saveStudent(student);
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> deleteStudent(int id) async {
    try {
      await _repository.deleteStudent(id);
      studentList.removeWhere((student) => student.id == id);
      _studentsController.add(studentList);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  void dispose() {
    _studentsController.close();
  }
}