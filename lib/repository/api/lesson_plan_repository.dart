import 'package:aluco/model/lesson_plan.dart';
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
}
