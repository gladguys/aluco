import 'package:aluco/model/class.dart';
import 'package:aluco/repository/api/class_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class ListClassesBloc extends BlocBase {
  final _repository = ClassRepository();
  final _classesController = BehaviorSubject<List<Class>>();

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
      if (classe.id == null) {
        classList.add(classe);
        _classesController.add(classList);
      } else {
        classList.removeWhere((c) => c.id == classe.id);
        classList.add(classe);
        _classesController.add(classList);
      }
    } catch(e) {
      throw Exception();
    }
  }

  Future<void> delete(int id) async {
    try {
      await _repository.delete(id);
      classList.removeWhere((classe) => classe.id == id);
      _classesController.add(classList);
    } catch(e) {
      throw Exception();
    }
  }

  @override
  void dispose() {
    _classesController.close();
    super.dispose();
  }
}