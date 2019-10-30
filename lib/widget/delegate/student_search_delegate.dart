import 'package:aluco/model/student.dart';
import 'package:aluco/screen/student/components/list_students.dart';
import 'package:aluco/screen/student/student_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'custom_search_delegate.dart';

class StudentSearchDelegate extends CustomSearchDelegate<Student> {
  StudentSearchDelegate(this.blocContext);

  BuildContext blocContext;

  @override
  Widget buildSuggestions(BuildContext context) {
    final _bloc = BlocProvider.getBloc<StudentBloc>();
    final List<Student> studentsList = query == ''
        ? _bloc.studentList
        : _bloc.studentList
            .where((student) =>
                student.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListStudents(studentsList);
  }
}
