import 'package:aluco/model/student_marked.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/screen/student/components/student_in_class_tile.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../class_students_bloc.dart';

class ListAddStudentClass extends StatelessWidget {
  const ListAddStudentClass(this.markedStudents);

  final List<StudentMarked> markedStudents;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (_, i) => StudentInClassTile(markedStudents[i]),
        separatorBuilder: (_, i) => const Divider(),
        itemCount: markedStudents.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => markedStudents.isNotEmpty ? _saveNewStudants(context) : null,
        child: Icon(AntDesign.getIconData('swap')),
      ),
    );
  }

  Future<void> _saveNewStudants(BuildContext context) async {
    await BlocProvider.getBloc<ClassStudentsBloc>().saveNewStudents();
    ALRouter.pop(context);
  }
}
