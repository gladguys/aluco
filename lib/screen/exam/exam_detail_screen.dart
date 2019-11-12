import 'package:aluco/model/exam.dart';
import 'package:aluco/model/student_grade.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'components/details_exam.dart';
import 'exam_bloc.dart';
import 'save_exam_grades.dart';

class ExamDetailScreen extends StatelessWidget {
  const ExamDetailScreen(this.exam);

  final Exam exam;

  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Prova',
      subtitle: exam.name,
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 6,
            child: DetailsExam(exam),
          ),
          Flexible(
            flex: 4,
            child: StreamBuilder<List<StudentGrade>>(
              stream: BlocProvider.getBloc<ExamBloc>().studentsGradesStream,
              builder: (_, snapshot) {
                print(snapshot);
                if (snapshot.hasData) {
                  print(snapshot.data);
                  final studentsGrades = snapshot.data;
                  return ListView.builder(
                    itemCount: studentsGrades.length,
                    itemBuilder: (_, i) {
                      return ListTile(
                        title: Text(studentsGrades[i].studentName),
                        trailing: Text(studentsGrades[i].grade?.toString() ?? 'S/N'),
                      );
                    }
                  );
                }
                return Center(
                  child: const CircularProgressIndicator(),
                );
              },
            ),
          ),
          RaisedButton(
            onPressed: () => ALRouter.push(context, SaveExamGrades()),
            child: const Text('+'),
          ),
        ],
      ),
    );
  }
}
