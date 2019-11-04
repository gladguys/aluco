import 'package:aluco/model/class.dart';
import 'package:aluco/widget/al_stream_builder.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'package:aluco/screen/classes/list_classes/list_classes_bloc.dart';
import 'class_tile.dart';

class ListClasses extends StatefulWidget {
  @override
  _ListClassesState createState() => _ListClassesState();
}

class _ListClassesState extends State<ListClasses> {
  ListClassesBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.getBloc<ListClassesBloc>();
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
      mainWidget: (dynamic classes) => ListView.separated(
        itemCount: classes.length,
        itemBuilder: (_, i) {
          if (i == classes.length-1) {
            return Column(
              children: <Widget>[
                ClassTile(classes[i]),
                const SizedBox(height: 80),
              ],
            );
          }
          return ClassTile(classes[i]);
        },
        separatorBuilder: (_, i) => const Divider(height: 1),
      ),
    );
  }
}
