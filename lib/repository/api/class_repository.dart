import 'package:aluco/model/class.dart';

import 'package:aluco/repository/api/API.dart';
import 'package:aluco/repository/core/abstract_class_repository.dart';
import 'package:aluco/repository/dio/dio_builder.dart';

class ClassRepository implements AbstractClassRepository {
  final _dio = DioBuilder.getDio();

  @override
  Future<List<Class>> getAll() async {
    try {
      final response = await _dio.get<dynamic>(CLASS);
      return List.generate(
        response.data.length,
            (int i) => Class.fromJson(
          response.data[i],
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
