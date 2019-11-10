import 'package:aluco/model/exam.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:aluco/widget/al_stream_builder.dart';
import 'package:aluco/widget/empty_state/exam_empty_state.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'components/exam_list.dart';
import 'components/save_exam_button.dart';
import 'exam_bloc.dart';

class ExamsScreen extends StatefulWidget {
  @override
  _ExamsScreenState createState() => _ExamsScreenState();
}

class _ExamsScreenState extends State<ExamsScreen> {
  final _bloc = BlocProvider.getBloc<ExamBloc>();

  @override
  void initState() {
    getAllExams();
    super.initState();
  }

  Future<void> getAllExams() async {
    await _bloc.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return ALStreamBuilder<List<Exam>>(
      stream: _bloc.examStream,
      mainWidget: (dynamic exams) => ALScaffold(
        title: 'Minhas Provas',
        body: _bloc.examsList.isNotEmpty
            ? ExamList(exams)
            : ExamEmptyState(),
        floatingActionButton:
        _bloc.examsList.isNotEmpty ? SaveExamButton() : null,
      ),
    );
  }
}
