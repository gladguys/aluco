import 'package:aluco/model/class.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:aluco/widget/al_stream_builder.dart';
import 'package:aluco/widget/empty_state/class_empty_state.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'components/list_classes.dart';
import 'components/save_class_button.dart';
import 'list_classes_bloc.dart';

class ListClassesScreen extends StatefulWidget {
  @override
  _ListClassesScreenState createState() => _ListClassesScreenState();
}

class _ListClassesScreenState extends State<ListClassesScreen> {
  final _bloc = BlocProvider.getBloc<ListClassesBloc>();

  @override
  void initState() {
    getAllClasses();
    super.initState();
  }

  Future<void> getAllClasses() async {
    await _bloc.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return ALStreamBuilder<List<Class>>(
      stream: _bloc.classStream,
      mainWidget: (dynamic classes) => ALScaffold(
        title: 'Minhas Turmas',
        body: _bloc.classList.isNotEmpty
            ? ListClasses(_bloc.classList)
            : ClassEmptyState(),
        floatingActionButton:
            _bloc.classList.isNotEmpty ? SaveClassButton() : null,
      ),
    );
  }
}
