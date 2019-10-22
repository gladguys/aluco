import 'package:aluco/model/class.dart';
import 'package:aluco/repository/class_repository.dart';

class ListClassesBloc {
  final _repository = ClassRepository();

  Future<List<Class>> getAllClasses() async {
    try {
      return _repository.getAllClasses();
    } catch (e) {
      throw Exception();
    }
  }
}