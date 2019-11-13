import 'package:aluco/model/exam.dart';
import 'package:aluco/model/exam_grade_dto.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'components/details_exam.dart';
import 'exam_bloc.dart';

class ExamDetailScreen extends StatefulWidget {
  const ExamDetailScreen(this.exam);

  final Exam exam;

  @override
  _ExamDetailScreenState createState() => _ExamDetailScreenState();
}

class _ExamDetailScreenState extends State<ExamDetailScreen> {
  final _examBloc = BlocProvider.getBloc<ExamBloc>();

  @override
  void initState() {
    super.initState();
    getGradesByExam(widget.exam.id);
  }

  Future<void> getGradesByExam(int examId) async =>
      await _examBloc.getGradesByExam(examId);

  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Prova',
      subtitle: widget.exam.name,
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 3,
            child: DetailsExam(widget.exam),
          ),
          const Text(
            'Notas por aluno',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Flexible(
            flex: 7,
            child: StreamBuilder<List<ExamGradeDTO>>(
              stream: _examBloc.studentsGradesStream,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  final studentsGrades = snapshot.data;
                  return ListView.builder(
                      itemCount: studentsGrades.length,
                      itemBuilder: (_, i) {
                        return ListTile(
                          title: Text(studentsGrades[i].studentName),
                          trailing: SizedBox(
                            width: 80,
                            child: TextFormField(
                              initialValue: studentsGrades[i].grade != null
                                  ? studentsGrades[i].grade.toStringAsFixed(2)
                                  : 'S/N',
                              onChanged: (grade) => _examBloc.updateGrade(
                                studentsGrades[i],
                                (grade != null && grade != '')
                                    ? double.parse(grade)
                                    : null,
                              ),
                            ),
                          ),
                        );
                      });
                }
                return Center(
                  child: const Text('Carregando Notas...'),
                );
              },
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await _examBloc.saveExamGrades(),
        child: Icon(Icons.save),
      ),
    );
  }

  @override
  void dispose() {
    _examBloc.cleanStudentesGrades();
    super.dispose();
  }
}
