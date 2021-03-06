import 'package:aluco/model/student_marked.dart';
import 'package:aluco/screen/classes/class_home/class_students/class_students_bloc.dart';
import 'package:aluco/screen/classes/class_home/class_students/components/list_add_student_class.dart';
import 'package:aluco/widget/empty_state/list_empty_state.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'custom_search_delegate.dart';

class AddStudentClassSearchDelegate
    extends CustomSearchDelegate<StudentMarked> {
  @override
  Widget buildSuggestions(BuildContext context) {
    final _bloc = BlocProvider.getBloc<ClassStudentsBloc>();
    final List<StudentMarked> studentsList = query == ''
        ? _bloc.allStudentsMarkedController.value
        : _bloc.allStudentsMarkedController.value
            .where((studentMarked) => studentMarked.student.name
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();

    return studentsList.isNotEmpty
        ? ListAddStudentClass(studentsList)
        : ListEmptyState();
  }
}
