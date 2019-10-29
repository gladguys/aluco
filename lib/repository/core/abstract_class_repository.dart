import 'package:aluco/model/class.dart';

abstract class AbstractClassRepository {
  Future<List<Class>> getAll();
}