import 'package:aluco/core/routing/al_router.dart';
import 'package:aluco/model/exam.dart';
import 'package:aluco/model/exam_grade_dto.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
import 'package:aluco/screen/exam/save_exam_screen.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_snackbar.dart';
import 'package:intl/intl.dart';

import 'components/details_exam.dart';
import 'exam_bloc.dart';
import 'exam_detail_screen_bloc.dart';

class ExamDetailScreen extends StatefulWidget {
  const ExamDetailScreen(this.exam);

  final Exam exam;

  @override
  _ExamDetailScreenState createState() => _ExamDetailScreenState();
}

class _ExamDetailScreenState extends State<ExamDetailScreen> {
  final _examBloc = BlocProvider.getBloc<ExamBloc>();
  final _screenBloc = ExamDetailScreenBloc();
  final dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    getGradesByExam(widget.exam.id);
  }

  Future<void> getGradesByExam(int examId) async =>
      await _examBloc.getGradesByExam(examId);

  @override
  Widget build(BuildContext context) {
    final nowString = dateFormat.format(DateTime.now());
    final isSameDay = dateFormat
        .parse(widget.exam.examDate)
        .isAtSameMomentAs(dateFormat.parse(nowString));

    return ALScaffold(
      title: 'Prova',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 8),
            DetailsExam(widget.exam),
            const SizedBox(height: 12),
            const Text(
              'Notas por aluno',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  border: Border.all(color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: <Widget>[
                    _getListGrades(isSameDay),
                    const SizedBox(height: 8),
                    _buttonConfirm(),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getListGrades(bool isSameDay) {
    return Expanded(
      child: StreamBuilder<List<ExamGradeDTO>>(
        stream: _examBloc.studentsGradesStream,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final studentsGrades = snapshot.data;
            return ListView.separated(
              separatorBuilder: (BuildContext context, int i) =>
                  const Divider(height: 1),
              itemCount: studentsGrades.length,
              itemBuilder: (_, i) {
                return _listTile(studentsGrades[i], isSameDay);
              },
            );
          }
          return Center(
            child: const Text('Carregando Notas...'),
          );
        },
      ),
    );
  }

  Widget _listTile(ExamGradeDTO studentGrade, bool isSameDay) {
    return ListTile(
      title: Text(studentGrade.studentName),
      trailing: Container(
        width: 65,
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Material(
          elevation: 1,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(8),
          child: TextFormField(
            readOnly: !isSameDay,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey[200],
            ),
            initialValue: studentGrade.grade != null
                ? studentGrade.grade.toStringAsFixed(2)
                : '',
            onChanged: (grade) {
              _examBloc.updateGrade(
                studentGrade,
                (grade != null && grade != '') ? double.parse(grade) : null,
              );
              _screenBloc.setIsDirty();
            },
            onTap: () {
              if (!isSameDay) {
                GGSnackbar.warning(
                  context: context,
                  title: 'Atenção',
                  message:
                      'As notas só podem ser lançadas no dia ou após a data de aplicação da prova.',
                  mainButtonText: 'ALTERAR\nDATA',
                  mainButtonOnPressed: () {
                    navigateToEdit(context, widget.exam);
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buttonConfirm() {
    return StreamBuilder<ScreenState>(
      stream: _screenBloc.stateStream,
      builder: (_, snapshot) => RaisedButton.icon(
        icon: Icon(Icons.done),
        label: const Text(
          'Confirmar Notas',
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 0,
          ),
        ),
        color: Colors.green[600],
        textColor: Colors.white,
        onPressed: snapshot.data == ScreenState.pristine
            ? null
            : () async {
          await _examBloc.saveExamGrades();
          GGSnackbar.success(message: 'Notas salvas com sucesso!', context: context);
        },
      ),
    );
  }

  Future<void> navigateToEdit(BuildContext context, Exam exam) async {
    final Exam examToSave = await ALRouter.push(context, SaveExamScreen(exam));
    final classId = BlocProvider.getBloc<ClassHomeBloc>().pickedClass.id;
    if (examToSave != null) {
      await BlocProvider.getBloc<ExamBloc>().save(examToSave, classId);
    }
  }

  @override
  void dispose() {
    _examBloc.cleanStudentesGrades();
    _screenBloc.dispose();
    super.dispose();
  }
}
