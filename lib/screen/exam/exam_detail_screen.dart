import 'package:aluco/model/exam.dart';
import 'package:aluco/model/exam_grade_dto.dart';
import 'package:aluco/utils/al_number_format.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gg_flutter_components/gg_snackbar.dart';

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
  List<MaskedTextController> _gradeControllerList;

  @override
  void initState() {
    super.initState();

    _gradeControllerList = [];

    getGradesByExam(widget.exam.id);
  }

  Future<void> getGradesByExam(int examId) async =>
      await _examBloc.getGradesByExam(examId);

  @override
  Widget build(BuildContext context) {
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
                    _getListGrades(),
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

  Widget _getListGrades() {
    return Expanded(
      child: StreamBuilder<List<ExamGradeDTO>>(
        stream: _examBloc.studentsGradesStream,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final studentsGrades = snapshot.data;

            for (ExamGradeDTO examGrade in studentsGrades) {
              final gradeController = MaskedTextController(
                  mask: '0,00',
                  text: ALNumberFormat.convertToDefaultDecimal(
                      examGrade.grade.toStringAsFixed(2)));

              gradeController.beforeChange = (String previous, String next) {
                if (next.length == 4) {
                  gradeController.updateMask('0,00');
                } else if (next.length == 5) {
                  gradeController.updateMask('00,00');

                  final double nextNumber = double.parse(
                      ALNumberFormat.convertToDefaultDecimal(next));
                  if (nextNumber < 0 || nextNumber > 10) {
                    gradeController.updateText(previous);
                    return false;
                  }
                }

                return true;
              };

              _gradeControllerList.add(gradeController);
            }

            return ListView.separated(
              separatorBuilder: (BuildContext context, int i) =>
                  const Divider(height: 1),
              itemCount: studentsGrades.length,
              itemBuilder: (_, i) {
                return _listTile(studentsGrades[i], i);
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

  Widget _listTile(ExamGradeDTO studentGrade, int i) {
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
            controller: _gradeControllerList[i],
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
            onChanged: (grade) {
              final gradeText = _gradeControllerList[i].text;
              _examBloc.updateGrade(
                studentGrade,
                (gradeText != null && gradeText != '')
                    ? double.parse(
                        ALNumberFormat.convertToDefaultDecimal(gradeText))
                    : null,
              );
              _screenBloc.setIsDirty();
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
                GGSnackbar.success(
                  message: 'Notas salvas com sucesso!',
                  context: context,
                );
              },
      ),
    );
  }

  @override
  void dispose() {
    for (MaskedTextController gradeController in _gradeControllerList) {
      gradeController.dispose();
    }
    _examBloc.cleanStudentesGrades();
    _screenBloc.dispose();
    super.dispose();
  }
}
