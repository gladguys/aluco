import 'dart:convert';

import 'package:aluco/model/class.dart';
import 'package:aluco/model/class_config.dart';
import 'package:aluco/model/student.dart';
import 'package:aluco/model/student_absence.dart';
import 'package:aluco/model/student_grades.dart';
import 'package:aluco/repository/api/API.dart';
import 'package:aluco/repository/core/abstract_class_repository.dart';
import 'package:aluco/repository/core/base_repository.dart';
import 'package:aluco/repository/dio/dio_builder.dart';

class ClassRepository extends BaseRepository<Class>
    implements AbstractClassRepository {
  final _dio = DioBuilder.getDio();

  ClassRepository(String basePath, Class instance) : super(basePath, instance);

  @override
  Future<List<Class>> getAllClassesByTeacher(int teacherId) async {
    try {
      final response =
          await _dio.get<dynamic>('$basePath/$SINGLE_TEACHER/$teacherId');
      return List.generate(response.data.length, (int i) {
        final classe = Class();
        return classe.fromJson(response.data[i]);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Student>> getStudentsByClass(int classId) async {
    try {
      final response = await _dio.get<dynamic>('$basePath/$classId/$STUDENT');
      return List.generate(response.data.length, (int i) {
        final student = Student();
        return student.fromJson(response.data[i]);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveClassStudents(int classId, List<Student> students) async {
    try {
      final List<Object> objects =
          students.map((student) => student.toJson()).toList();
      final map = <String, dynamic>{'studentDTOS': objects};
      await _dio.post<dynamic>('$basePath/$classId/$STUDENT',
          data: jsonEncode(map));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> unlinkStudentFromClass(int classId, int studentId) async {
    try {
      await _dio.delete<dynamic>('$basePath/$classId/$STUDENT/$studentId');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<StudentGrades>> getGradesBoard(int classId) async {
    try {
      final response = await _dio.get<dynamic>('$basePath/$classId/$GRADE');
      return List.generate(
        response.data.length,
        (int i) => StudentGrades.fromJson(response.data[i]),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<StudentAbsence>> getAbsences(int classId) async {
    try {
      final response = await _dio.get<dynamic>('$basePath/$classId/$ABSENCE');
      return List.generate(
        response.data.length,
        (int i) => StudentAbsence.fromJson(response.data[i]),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveClassConfig(int classId, Class classe) async {
    try {
      await _dio.post<dynamic>('$basePath//$classId/$CONFIG',
          data: jsonEncode(classe.toJsonConfig()));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ClassConfig> getClassConfig(int classId) async {
    try {
      final response = await _dio.get<dynamic>('$CLASS/$classId/$CONFIG');
      if (response.data != '') {
        return ClassConfig.fromJson(response.data);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
