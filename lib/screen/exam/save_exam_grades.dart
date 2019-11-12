import 'package:aluco/model/student.dart';
import 'package:aluco/model/student_grade.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:aluco/widget/al_stream_builder.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'exam_bloc.dart';

class SaveExamGrades extends StatefulWidget {
  @override
  _SaveExamGradesState createState() => _SaveExamGradesState();
}

class _SaveExamGradesState extends State<SaveExamGrades> {
  Future<List<Student>> studentsFuture;
  final _examBloc = BlocProvider.getBloc<ExamBloc>();
  final _classBloc = BlocProvider.getBloc<ClassHomeBloc>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    initStudentsGrades(_classBloc.pickedClass.id, _examBloc.pickedExam.id);
    super.initState();
  }

  Future<void> initStudentsGrades(int classId, int examId) async {
    await _examBloc.initStudentsGrades(classId, examId);
  }

  @override
  Widget build(BuildContext context) {
    return ALStreamBuilder<List<StudentGrade>>(
      stream: _examBloc.studentsGradesStream,
      mainWidget: (dynamic studentsGrades) => ALScaffold(
        title: 'Atribuir notas',
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              await _examBloc.saveInitialGrades(
                  BlocProvider.getBloc<ExamBloc>().pickedExam.id);
              ALRouter.pop(context);
            },
          )
        ],
        body: Form(
          key: _formKey,
          child: ListView.separated(
            itemBuilder: (_, i) => ListTile(
              title: Text(_examBloc.studentsGradesList[i].studentName),
              trailing: SizedBox(
                width: 80,
                child: TextFormField(
                  key: ValueKey(_examBloc.studentsGradesList[i].studentId),
                  keyboardType: TextInputType.number,
                  initialValue:
                      _examBloc.studentsGradesList[i].grade?.toString() ?? '',
                  onChanged: (grade) => _examBloc.updateStudentGrade(
                      _examBloc.studentsGradesList[i].studentId, grade),
                ),
              ),
            ),
            separatorBuilder: (_, i) => const Divider(),
            itemCount: studentsGrades.length,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _examBloc.cleanStudentesGrades();
  }
}
