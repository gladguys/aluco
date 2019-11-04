import 'dart:convert';

import 'package:aluco/model/class.dart';
import 'package:aluco/model/student.dart';

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

  @override
  Future<List<Student>> getStudents(int classId) async {
    try {
      final response = await _dio.get<dynamic>('$CLASS/$classId/$STUDENT');
      return List.generate(
        response.data.length,
        (int i) => Student.fromJson(
          response.data[i],
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> save(Class classe) async {
    try {
      await _dio.post<dynamic>(CLASS, data: classe.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveStudents(int classId, List<Student> students) async {
    try {
      final List<Object> objects =
          students.map((student) => student.toJson()).toList();
      final map = <String, dynamic>{'studentDTOS': objects};
      await _dio.post<dynamic>('$CLASS/$classId/$STUDENT',
          data: jsonEncode(map));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> unlinkStudentFromClass(int classId, int studentId) async {
    try {
      await _dio.delete<dynamic>('$CLASS/$classId/$STUDENT/$studentId');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      await _dio.delete<dynamic>('$CLASS/$id');
    } catch (e) {
      rethrow;
    }
  }
}
