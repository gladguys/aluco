import 'package:aluco/model/class.dart';
import 'package:aluco/model/exam.dart';
import 'package:aluco/model/lesson_plan.dart';
import 'package:aluco/model/student.dart';
import 'package:aluco/repository/api/API.dart';
import 'package:aluco/repository/api/auth_repository.dart';
import 'package:aluco/repository/api/call_repository.dart';
import 'package:aluco/repository/api/class_repository.dart';
import 'package:aluco/repository/api/exam_repository.dart';
import 'package:aluco/repository/api/file_upload_repository.dart';
import 'package:aluco/repository/api/lesson_plan_repository.dart';
import 'package:aluco/repository/api/student_repository.dart';
import 'package:aluco/repository/core/abstract_auth_repository.dart';
import 'package:aluco/repository/core/abstract_call_repository.dart';
import 'package:aluco/repository/core/abstract_class_repository.dart';
import 'package:aluco/repository/core/abstract_exam_repository.dart';
import 'package:aluco/repository/core/abstract_file_upload_repository.dart';
import 'package:aluco/repository/core/abstract_lesson_repository.dart';
import 'package:aluco/repository/core/abstract_student_repository.dart';
import 'package:get_it/get_it.dart';

GetIt G = GetIt.I;

void setupLocator() {
  G.registerSingleton<AbstractAuthRepository>(AuthRepository());
  G.registerLazySingleton<AbstractCallRepository>(() => CallRepository());
  G.registerLazySingleton<AbstractClassRepository>(
      () => ClassRepository(CLASS, Class()));
  G.registerLazySingleton<AbstractExamRepository>(
      () => ExamRepository(EXAM, Exam()));
  G.registerLazySingleton<AbstractFileUploadRepository>(
      () => FileUploadRepository());
  G.registerLazySingleton<AbstractLessonPlanRepository>(
      () => LessonPlanRepository(LESSON, LessonPlan()));
  G.registerLazySingleton<AbstractStudentRepository>(
      () => StudentRepository(STUDENT, Student()));
}
