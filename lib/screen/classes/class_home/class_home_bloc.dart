import 'package:aluco/model/class.dart';
import 'package:aluco/model/student.dart';
import 'package:aluco/repository/api/student_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class ClassHomeBloc extends BlocBase {
  final classStudentsController = BehaviorSubject<List<Student>>.seeded([]);
  final _repository = StudentRepository();
  Class _class;

  Class get pickedClass => _class;
  List<Student> get classStudents => classStudentsController.value;

  void setClass(Class classe) {
    _class = classe;
  }

  Future<void> initializeClassStudents() async {
    classStudentsController.add(await _repository.getAll());
  }

  void cleanBloc() {
    classStudentsController.add([]);
  }
}