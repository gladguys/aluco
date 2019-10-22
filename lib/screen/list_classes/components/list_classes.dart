import 'package:aluco/model/class.dart';
import 'package:aluco/screen/list_classes/list_classes_bloc.dart';
import 'package:aluco/widget/al_error.dart';
import 'package:aluco/widget/al_waiting_indicator.dart';
import 'package:flutter/material.dart';

import 'list_class_tile.dart';

class ListClasses extends StatelessWidget {
  final _bloc = ListClassesBloc();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Class>>(
      future: _bloc.getAllClasses(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          final classList = snapshot.data;
          return ListView.separated(
              itemCount: classList.length,
              itemBuilder: (_, i) => ListClassTile(classList[i]),
              separatorBuilder: (_, i) => const Divider(),
          );
        } else if (snapshot.hasError) {
          return ALError();
        }
        return ALWaitingIndicator();
      },
    );
  }
}
