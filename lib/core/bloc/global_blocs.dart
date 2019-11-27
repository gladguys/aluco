import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

import '../../screen/classes/class_home/class_students/class_students_bloc.dart';
import '../../screen/classes/list_classes/list_classes_bloc.dart';
import '../../screen/exam/exam_bloc.dart';
import '../../screen/signin/signin_bloc.dart';
import '../../screen/student/student_bloc.dart';

import 'linear_loading_bloc.dart';
import 'loading_bloc.dart';

final globalBlocs = [
  Bloc((i) => SigninBloc()),
  Bloc((i) => ClassHomeBloc()),
  Bloc((i) => ClassStudentsBloc()),
  Bloc((i) => ListClassesBloc()),
  Bloc((i) => StudentBloc()),
  Bloc((i) => ExamBloc()),
  Bloc((i) => LoadingBloc()),
  Bloc((i) => LinearLoadingBloc()),
];