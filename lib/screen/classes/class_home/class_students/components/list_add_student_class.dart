import 'package:aluco/core/routing/al_router.dart';
import 'package:aluco/model/student_marked.dart';
import 'package:aluco/screen/exam/exam_bloc.dart';
import 'package:aluco/screen/student/components/student_in_class_tile.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_snackbar.dart';

import '../class_students_bloc.dart';

class ListAddStudentClass extends StatelessWidget {
  const ListAddStudentClass(this.markedStudents);

  final List<StudentMarked> markedStudents;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int i) =>
              const SizedBox(height: 4),
          itemCount: markedStudents.length,
          itemBuilder: (_, i) {
            if (isLastFromList(i, markedStudents.length)) {
              return Column(
                children: <Widget>[
                  StudentInClassTile(markedStudents[i]),
                  const SizedBox(height: 80),
                ],
              );
            }
            return StudentInClassTile(markedStudents[i]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.done),
        label: const Text(
          'Confirmar',
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 0,
          ),
        ),
        backgroundColor: Colors.green[600],
        onPressed: () =>
            markedStudents.isNotEmpty ? _saveNewStudants(context) : null,
      ),
    );
  }

  bool isLastFromList(int index, int listSize) {
    return index == listSize - 1;
  }

  Future<void> _saveNewStudants(BuildContext context) async {
    await BlocProvider.getBloc<ClassStudentsBloc>().saveNewStudents();
    ALRouter.pop(context);
    GGSnackbar.success(message: 'Alunos adicionados com sucesso!', context: context);
    final examId = BlocProvider.getBloc<ExamBloc>().pickedExam.id;
    if (examId != null) {
      await BlocProvider.getBloc<ExamBloc>().getGradesByExam(examId);
    }
  }
}
