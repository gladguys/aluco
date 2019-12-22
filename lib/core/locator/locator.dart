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
import 'package:get_it/get_it.dart';

GetIt G = GetIt.I;

void setupLocator() {
  G.registerSingleton<AuthRepository>(AuthRepository());
  G.registerLazySingleton<CallRepository>(() => CallRepository());
  G.registerLazySingleton<ClassRepository>(
      () => ClassRepository(CLASS, Class()));
  G.registerLazySingleton<ExamRepository>(() => ExamRepository(EXAM, Exam()));
  G.registerLazySingleton<FileUploadRepository>(() => FileUploadRepository());
  G.registerLazySingleton<LessonPlanRepository>(
      () => LessonPlanRepository(LESSON, LessonPlan()));
  G.registerLazySingleton<StudentRepository>(
      () => StudentRepository(STUDENT, Student()));
}
