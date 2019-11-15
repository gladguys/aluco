import 'package:aluco/model/exam.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
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
  final _classBloc = BlocProvider.getBloc<ClassHomeBloc>();

  @override
  void initState() {
    getAllExamsByClass();
    super.initState();
  }

  Future<void> getAllExamsByClass() async {
    await _bloc.getExamsByClass(_classBloc.pickedClass.id);
  }

  @override
  Widget build(BuildContext context) {
    return ALStreamBuilder<List<Exam>>(
      stream: _bloc.examStream,
      mainWidget: (dynamic exams) => ALScaffold(
        title: 'Minhas Provas',
        body: _bloc.examsList.isNotEmpty ? ExamList(exams) : ExamEmptyState(),
        floatingActionButton:
            _bloc.examsList.isNotEmpty ? const SaveExamButton() : null,
      ),
    );
  }
}
