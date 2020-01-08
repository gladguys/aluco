import 'package:aluco/core/locator/locator.dart';
import 'package:aluco/model/class.dart';
import 'package:aluco/repository/api/class_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class ListClassesBloc extends BlocBase {
  final _repository = G<ClassRepository>();
  final _classesController = BehaviorSubject<List<Class>>();

  Stream<List<Class>> get classStream => _classesController.stream;
  List<Class> get classList => _classesController.value;

  Future<void> getAll() async {
    try {
      final classes = await _repository.getAll();
      for (Class classe in classes) {
        final config = await _repository.getClassConfig(classe.id);
        if (config != null) {
          classe.maxQntAbsence = config.maxQntAbsence;
          classe.minimumAverage = config.minimumAverage;
        }
      }
      _classesController.add(classes);
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> save(Class classe) async {
    try {
      final classSaved = await _repository.save(classe);

      if (classe.id == null) {
        await _repository.saveClassConfig(classSaved.id, classe);
      }

      if (classe.id == null) {
        classList.add(classSaved);
        _classesController.add(classList);
      } else {
        classList.remove(classe);
        classList.add(classSaved);
        _classesController.add(classList);
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> delete(Class classe) async {
    try {
      await _repository.delete(classe.id);
      classList.remove(classe);
      _classesController.add(classList);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  void dispose() {
    _classesController.close();
    super.dispose();
  }
}
