import 'package:aluco/core/locator/locator.dart';
import 'package:aluco/core/notification/notification_service.dart';
import 'package:aluco/model/class.dart';
import 'package:aluco/model/lesson_plan.dart';
import 'package:aluco/model/student.dart';
import 'package:aluco/repository/api/class_repository.dart';
import 'package:aluco/repository/api/lesson_plan_repository.dart';
import 'package:aluco/repository/api/student_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class ClassHomeBloc extends BlocBase {
  final classStudentsController = BehaviorSubject<List<Student>>.seeded([]);
  final classPlannedLessonsController =
      BehaviorSubject<List<LessonPlan>>.seeded([]);
  final _lessonRepository = G<LessonPlanRepository>();
  final _studentRepository = G<StudentRepository>();
  final _classRepository = G<ClassRepository>();
  final dateFormat = DateFormat('dd/MM/yyyy');
  Class _class;

  Class get pickedClass => _class;
  List<Student> get classStudents => classStudentsController.value;
  List<LessonPlan> get classPlannedLessons =>
      classPlannedLessonsController.value;

  void setClass(Class classe) {
    _class = classe;
    loadClassConfig(_class.id);
  }

  Future<void> loadClassConfig(int classId) async {
    try {
      final config = await _classRepository.getClassConfig(classId);
      _class.maxQntAbsence = config.maxQntAbsence;
      _class.minimumAverage = config.minimumAverage;
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> initializeClassStudents() async {
    try {
      classStudentsController.add(await _studentRepository.getAll());
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> initializeClassPlannedLessons() async {
    try {
      classPlannedLessonsController.add(
          await _lessonRepository.getPlannedLessonsByClass(pickedClass.id));
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> saveLessonPlan(LessonPlan lessonPlan) async {
    try {
      lessonPlan.classId = pickedClass.id;
      final lessonPlanSaved = await _lessonRepository.save(lessonPlan);
      final lessonPlanDate = dateFormat.parse(lessonPlan.lessonDate);
      final notificationDate = DateTime(
          lessonPlanDate.year, lessonPlanDate.month, lessonPlanDate.day, 8);

      if (lessonPlan.id == null) {
        classPlannedLessons.add(lessonPlanSaved);
        classPlannedLessonsController.add(classPlannedLessons);
        await NotificationService.scheduleNotification(
            id: lessonPlanSaved.id,
            title: lessonPlan.metodology,
            body: lessonPlan.content,
            notificationDate: notificationDate,
            payload: lessonPlanSaved.id.toString());
      } else {
        await NotificationService.cancelNotification(lessonPlan.id);
        await NotificationService.scheduleNotification(
            id: lessonPlanSaved.id,
            title: lessonPlan.metodology,
            body: lessonPlan.content,
            notificationDate: notificationDate,
            payload: lessonPlanSaved.id.toString());

        classPlannedLessons.remove(lessonPlan);
        classPlannedLessons.add(lessonPlanSaved);
        classPlannedLessonsController.add(classPlannedLessons);
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> deleteLessonPlan(LessonPlan lessonPlan) async {
    try {
      await _lessonRepository.delete(lessonPlan.id);
      classPlannedLessons.remove(lessonPlan);
      classPlannedLessonsController.add(classPlannedLessons);
    } catch (e) {
      throw Exception();
    }
  }

  Future<LessonPlan> getLessonPlanById(int id) async {
    try {
      return _lessonRepository.getById(id);
    } catch (e) {
      throw Exception();
    }
  }

  LessonPlan getLessonPlanFromDate(DateTime date) {
    return classPlannedLessons.firstWhere(
        (lesson) => lesson.lessonDate == dateFormat.format(date),
        orElse: () => null);
  }

  void cleanBloc() {
    classStudentsController.add([]);
    classPlannedLessonsController.add([]);
  }
}
