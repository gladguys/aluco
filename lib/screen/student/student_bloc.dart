import 'package:aluco/model/student.dart';
import 'package:aluco/repository/student_repository.dart';

class StudentBloc {
  final _repository = StudentRepository();

  Future<List<Student>> getAllStudents() async {
    try {
      return _repository.getAllStudents();
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> saveStudent(Student student) async {
    try {
      return _repository.saveStudent(student);
    } catch (e) {
      throw Exception();
    }
  }
}