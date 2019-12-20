import 'package:aluco/model/base_model.dart';
import 'package:aluco/repository/dio/dio_builder.dart';
import 'package:dio/dio.dart';

import 'abstract_repository.dart';

class BaseRepository<T extends BaseModel<T>> implements AbstractRepository<T> {
  BaseRepository(this.basePath, this._instance);

  final String basePath;
  final T _instance;
  final _dio = DioBuilder.getDio();

  @override
  Future<List<T>> getAll() async {
    try {
      final response = await _dio.get<dynamic>(basePath);
      return List.generate(
        response.data.length,
        (i) => _instance.fromJson(response.data[i]),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<T> getById(int id) async {
    try {
      final response = await _dio.get<dynamic>('$basePath/$id');
      return _instance.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<T> save(T t) async {
    Response response;
    try {
      if (t.getId() == null) {
        response = await _dio.post<dynamic>(basePath, data: t.toJson());
      } else {
        response = await _dio.put<dynamic>(basePath, data: t.toJson());
      }
      return _instance.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      await _dio.delete<dynamic>('$basePath/$id');
    } catch (e) {
      rethrow;
    }
  }
}
