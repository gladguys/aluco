import 'package:bloc_pattern/bloc_pattern.dart';

import 'screen/classes/class_home/class_home_bloc.dart';
import 'screen/classes/list_classes/list_classes_bloc.dart';
import 'screen/student/student_bloc.dart';

final globalBlocs = [
  Bloc((i) => ClassHomeBloc()),
  Bloc((i) => ListClassesBloc()),
  Bloc((i) => StudentBloc()),
];