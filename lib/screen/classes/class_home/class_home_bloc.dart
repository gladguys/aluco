import 'package:aluco/model/class.dart';
import 'package:aluco/model/student.dart';
import 'package:aluco/repository/api/student_repository.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class ClassHomeBloc extends Bloc {
  final _classStudentsController = BehaviorSubject<List<Student>>.seeded([]);
  final _repository = StudentRepository();
  Class _class;

  Class get pickedClass => _class;
  List<Student> get classStudents => _classStudentsController.value;

  ClassHomeBloc(Class classe)  {
    _class = classe;
  }

  void setClass(Class classe) {
    _class = classe;
  }

  Future<void> initializeClassStudents() async {
    _classStudentsController.add(await _repository.getAll());
  }

  @override
  void dispose() {
    _classStudentsController.add([]);
    _classStudentsController.close();
  }
}