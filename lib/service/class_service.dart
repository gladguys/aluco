import 'package:aluco/model/class.dart';
import 'package:aluco/repository/class_repository.dart';

class ClassService {
  final _repository = ClassRepository();

  Future<List<Class>> getAllClasses() async {
    return await _repository.getAllClasses();
  }
}