import 'package:aluco/model/student.dart';

import 'package:aluco/repository/api/API.dart';
import 'package:aluco/repository/core/abstract_student_repository.dart';
import 'package:aluco/repository/dio/dio_builder.dart';
import 'package:dio/dio.dart';

class StudentRepository implements AbstractStudentRepository {
  final _dio = DioBuilder.getDio();

  @override
  Future<List<Student>> getAll() async {
    try {
      final response = await _dio.get<dynamic>(STUDENT);
      return List.generate(
        response.data.length,
        (i) => Student.fromJson(
          response.data[i],
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Student> getById(int id) async {
    try {
      final response = await _dio.get<dynamic>('$STUDENT/$id');
      return Student.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Student> save(Student student) async {
    Response response;
    try {
      if (student.id == null) {
        response = await _dio.post<dynamic>(STUDENT, data: student.toJson());
      } else {
        response = await _dio.put<dynamic>(STUDENT, data: student.toJson());
      }
      return Student.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      await _dio.delete<dynamic>('$STUDENT/$id');
    } catch (e) {
      rethrow;
    }
  }
}
