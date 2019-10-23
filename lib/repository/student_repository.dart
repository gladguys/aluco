import 'package:aluco/model/student.dart';

import 'API.dart';
import 'dio/dio_builder.dart';

class StudentRepository {
  final _dio = DioBuilder.getDio();

  Future<List<Student>> getAllStudents() async {
    try {
      final response = await _dio.get<dynamic>('$API_URL/$STUDENT');
      return List.generate(
        response.data.length,
        (i) => Student.fromJson(
          response.data[i],
        ),
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> saveStudent(Student student) async {
    try {
      await _dio.post<dynamic>('$API_URL/$STUDENT', data: student.toJson());
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
