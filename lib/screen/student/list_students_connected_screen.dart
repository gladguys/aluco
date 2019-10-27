import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';

import 'list_students_screen.dart';
import 'student_bloc.dart';

class ListStudentsConnectedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentBloc>(
      creator: (context, _) => StudentBloc(),
      child: ListStudentsScreen(),
    );
  }
}
