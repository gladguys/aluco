import 'package:aluco/model/class.dart';
import 'package:aluco/repository/class_repository.dart';

class ClassService {
  final _repository = ClassRepository();

  Future<List<Class>> getAllClasses() async {
    try {
      return await _repository.getAllClasses();
    } catch (e) {
      throw Exception();
    }
  }
}