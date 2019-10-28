import 'package:aluco/model/class.dart';
import 'package:aluco/repository/api/class_repository.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class ClassBloc extends Bloc {
  final _repository = ClassRepository();
  final _classesController = BehaviorSubject<List<Class>>.seeded([]);

  Stream<List<Class>> get classStream => _classesController.stream;
  List<Class> get classList => _classesController.value;

  Future<void> getAll() async {
    try {
      _classesController.add(await _repository.getAll());
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> save(Class classe) async {
    try {
      await _repository.save(classe);
    } catch(e) {
      throw Exception();
    }
  }

  @override
  void dispose() {
    _classesController.close();
  }
}