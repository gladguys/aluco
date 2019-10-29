import 'package:aluco/model/class.dart';
import 'package:aluco/repository/api/class_repository.dart';

class ListClassesBloc {
  final _repository = ClassRepository();

  Future<List<Class>> getAll() async {
    try {
      return _repository.getAll();
    } catch (e) {
      throw Exception();
    }
  }
}