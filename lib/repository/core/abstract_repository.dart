abstract class AbstractRepository<T> {
  Future<List<T>> getAll();
  Future<T> getById(int id);
  Future<T> save(T t);
  Future<void> delete(int id);
}