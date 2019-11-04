import 'package:aluco/model/class.dart';
import 'package:aluco/widget/al_error.dart';
import 'package:aluco/widget/al_waiting_indicator.dart';
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
    return StreamBuilder<List<Class>>(
      stream: _bloc.classStream,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          final classList = snapshot.data;
          return ListView.separated(
            itemCount: classList.length,
            itemBuilder: (_, i) {
              if (i == classList.length-1) {
                return Column(
                  children: <Widget>[
                    ClassTile(classList[i]),
                    const SizedBox(height: 80),
                  ],
                );
              }
              return ClassTile(classList[i]);
            },
            separatorBuilder: (_, i) => const Divider(height: 1),
          );
        } else if (snapshot.hasError) {
          return ALError();
        }
        return const ALWaitingIndicator();
      },
    );
  }
}
