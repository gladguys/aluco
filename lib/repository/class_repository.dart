import 'package:aluco/model/class.dart';

import 'API.dart';
import 'dio_builder.dart';

class ClassRepository {
  final _dio = DioBuilder.getDio();

  Future<List<Class>> getAllClasses() async {
    try {
      final response = await _dio.get<dynamic>('$API_URL/$CLASS/q');
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
