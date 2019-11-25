import 'package:aluco/model/lesson_plan.dart';

import 'base_repository.dart';

abstract class AbstractLessonPlanRepository extends BaseRepository<LessonPlan> {
  AbstractLessonPlanRepository(String basePath, LessonPlan instance) : super(basePath, instance);

  Future<List<LessonPlan>> getPlannedLessonsByClass(int classId);
}