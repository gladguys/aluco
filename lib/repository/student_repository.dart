import 'package:aluco/model/student.dart';

import 'API.dart';
import 'dio/dio_builder.dart';

class StudentRepository {
  final _dio = DioBuilder.getDio();

  Future<List<Student>> getAllStudents() async {
    try {
      final response = await _dio.get<dynamic>(STUDENT);
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
      if (student.id == null) {
        await _dio.post<dynamic>(STUDENT, data: student.toJson());
      } else {
        await _dio.put<dynamic>(STUDENT, data: student.toJson());
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteStudent(int id) async {
    try {
      await _dio.delete<dynamic>('$STUDENT/$id');
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
