import 'package:aluco/model/class.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'components/list_classes.dart';
import 'list_classes_bloc.dart';
import 'save_class_screen.dart';

class ListClassesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Minhas Turmas',
      body: ListClasses(),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: const Text(
          'Adicionar',
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 0,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).accentColor,
        onPressed: () async {
          final Class classe =
              await ALRouter.push(context, const SaveClassScreen());
          if (classe != null) {
            await BlocProvider.getBloc<ListClassesBloc>().save(classe);
          }
        },
      ),
    );
  }
}
