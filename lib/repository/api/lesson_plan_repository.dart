import 'package:aluco/model/lesson_plan.dart';
import 'package:aluco/repository/api/API.dart';
import 'package:aluco/repository/core/abstract_lesson_repository.dart';
import 'package:aluco/repository/core/base_repository.dart';
import 'package:aluco/repository/dio/dio_builder.dart';

class LessonPlanRepository extends BaseRepository<LessonPlan>
    implements AbstractLessonPlanRepository {
  LessonPlanRepository(String basePath, LessonPlan instance)
      : super(basePath, instance);

  final _dio = DioBuilder.getDio();

  @override
  Future<List<LessonPlan>> getPlannedLessonsByClass(int classId) async {
    try {
      final response = await _dio.get<dynamic>(basePath,
          queryParameters: <String, dynamic>{'classId': classId.toString()});
      return List.generate(
        response.data.length,
        (int i) {
          final lessonPlan = LessonPlan();
          return lessonPlan.fromJson(response.data[i]);
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LessonPlan> getLastEditedLessonsPlan(int classId) async {
    try {
      final response = await _dio
          .get<dynamic>('$basePath/$SINGLE_CLASS/$classId/next-lesson');
      if (response.data != null) {
        final instance = LessonPlan();
        return instance.fromJson(response.data);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LessonPlan> getNextLessonsPlan(int classId) async {
    try {
      final response = await _dio
          .get<dynamic>('$basePath/$SINGLE_CLASS/$classId/latest-edited');
      if (response.data != null) {
        final instance = LessonPlan();
        return instance.fromJson(response.data);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
