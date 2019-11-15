import 'package:aluco/model/student.dart';
import 'package:aluco/screen/student/components/list_students.dart';
import 'package:aluco/screen/student/student_bloc.dart';
import 'package:aluco/widget/empty_state/list_empty_state.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'custom_search_delegate.dart';

class StudentSearchDelegate extends CustomSearchDelegate<Student> {
  @override
  Widget buildSuggestions(BuildContext context) {
    final _bloc = BlocProvider.getBloc<StudentBloc>();
    final List<Student> studentsList = query == ''
        ? _bloc.studentList
        : _bloc.studentList
            .where((student) =>
                student.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return studentsList.isNotEmpty
        ? ListStudents(studentsList)
        : ListEmptyState();
  }
}
