import 'package:aluco/model/class.dart';

abstract class AbstractClassRepository {
  Future<List<Class>> getAll();
  Future<void> save(Class classe);
  Future<void> delete(int id);
}