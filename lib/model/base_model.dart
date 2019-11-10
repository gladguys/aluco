import 'codable.dart';

abstract class BaseModel<T> implements Codable<T> {
  int getId();
}