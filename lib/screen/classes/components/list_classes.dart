import 'package:aluco/model/class.dart';
import 'package:aluco/widget/al_error.dart';
import 'package:aluco/widget/al_waiting_indicator.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';

import '../class_bloc.dart';
import 'class_tile.dart';

class ListClasses extends StatefulWidget {
  @override
  _ListClassesState createState() => _ListClassesState();
}

class _ListClassesState extends State<ListClasses> {
  ClassBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<ClassBloc>(context);
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
              itemBuilder: (_, i) => ClassTile(classList[i]),
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
