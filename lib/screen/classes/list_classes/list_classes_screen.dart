import 'package:aluco/model/class.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'components/list_classes.dart';
import 'list_classes_bloc.dart';
import 'save_class_screen.dart';

class ListClassesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Minhas Turmas',
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            MaterialCommunityIcons.getIconData('face-profile'),
            size: 38,
            color: const Color(0xFF389952),
          ),
        ),
      ],
      body: ListClasses(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final _bloc = BlocProvider.of<ListClassesBloc>(context);
          final Class classe = await ALRouter.push(context, const SaveClassScreen());
          if (classe != null) {
            await _bloc.save(classe);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
