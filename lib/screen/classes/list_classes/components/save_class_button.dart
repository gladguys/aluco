import 'package:aluco/model/class.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../list_classes_bloc.dart';
import '../save_class_screen.dart';

class SaveClassButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
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
    );
  }
}
