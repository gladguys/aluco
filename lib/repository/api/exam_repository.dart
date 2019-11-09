import 'package:aluco/model/exam.dart';

import 'package:aluco/repository/api/API.dart';
import 'package:aluco/repository/core/abstract_exam_repository.dart';
import 'package:aluco/repository/dio/dio_builder.dart';
import 'package:dio/dio.dart';

class ExamRepository implements AbstractExamRepository {
  final _dio = DioBuilder.getDio();

  @override
  Future<List<Exam>> getAll() async {
    try {
      final response = await _dio.get<dynamic>(EXAM);
      return List.generate(
        response.data.length,
            (int i) => Exam.fromJson(
          response.data[i],
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Exam> save(Exam exam) async {
    Response response;
    try {
      if (exam.id == null) {
        response = await _dio.post<dynamic>(EXAM, data: exam.toJson());
      } else {
        response = await _dio.put<dynamic>(EXAM, data: exam.toJson());
      }
      return Exam.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
