import 'package:aluco/core/routing/al_router.dart';
import 'package:aluco/model/exam.dart';
import 'package:aluco/model/exam_grade_dto.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
import 'package:aluco/screen/exam/save_exam_screen.dart';
import 'package:aluco/utils/al_number_format.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:aluco/widget/empty_state/exam_grade_student_empty_state.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gg_flutter_components/gg_snackbar.dart';
import 'package:gg_flutter_components/loading/gg_loading_double_bounce.dart';
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
    final nowString = dateFormat.format(DateTime.now());
    final isEditable = dateFormat
            .parse(widget.exam.examDate)
            .isBefore(dateFormat.parse(nowString)) ||
        dateFormat
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
                child: _getListGrades(isEditable),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getListGrades(bool isEditable) {
    return StreamBuilder<List<ExamGradeDTO>>(
      stream: _examBloc.studentsGradesStream,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          final studentsGrades = snapshot.data;
          return studentsGrades.isNotEmpty
              ? _listAndButton(studentsGrades, isEditable)
              : ExamGradeStudentEmptyState();
        }
        return const GGLoadingDoubleBounce(size: 20);
      },
    );
  }

  Widget _listAndButton(List<ExamGradeDTO> studentsGrades, bool isEditable) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<List<ExamGradeDTO>>(
            stream: _examBloc.studentsGradesStream,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                final studentsGrades = snapshot.data;

                for (ExamGradeDTO examGrade in studentsGrades) {
                  MaskedTextController gradeController;
                  if (examGrade.grade == 10.0) {
                    gradeController = MaskedTextController(
                      mask: '00,00',
                      text: '10.0',
                    );
                  } else {
                    gradeController = MaskedTextController(
                      mask: '0,00',
                      text: ALNumberFormat.convertToDefaultDecimal(
                        examGrade.grade?.toStringAsFixed(2),
                      ),
                    );

                    gradeController.beforeChange =
                        (String previous, String next) {
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
                  }
                  _gradeControllerList.add(gradeController);
                }

                return ListView.separated(
                  separatorBuilder: (BuildContext context, int i) =>
                      const Divider(height: 1),
                  itemCount: studentsGrades.length,
                  itemBuilder: (_, i) =>
                      _listTile(studentsGrades[i], i, isEditable),
                );
              }
              return const Center(
                child: Text('Carregando Notas...'),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        _buttonConfirm(),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _listTile(ExamGradeDTO studentGrade, int i, bool isEditable) {
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
            readOnly: !isEditable,
            enableInteractiveSelection: false,
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
            onTap: () {
              if (!isEditable) {
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
                GGSnackbar.success(
                  message: 'Notas salvas com sucesso!',
                  context: context,
                );
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
    for (MaskedTextController gradeController in _gradeControllerList) {
      gradeController.dispose();
    }
    _examBloc.cleanStudentesGrades();
    _screenBloc.dispose();
    super.dispose();
  }
}
