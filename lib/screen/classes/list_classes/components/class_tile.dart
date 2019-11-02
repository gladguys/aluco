import 'package:aluco/model/class.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/screen/classes/class_home/class_home_screen.dart';
import 'package:aluco/screen/classes/list_classes/list_classes_bloc.dart';
import 'package:aluco/screen/classes/list_classes/save_class_screen.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/button/gg_circle_button.dart';
import 'package:gg_flutter_components/dialog/gg_confirm_delete_dialog.dart';
import 'package:gg_flutter_components/dialog/gg_dialog.dart';

class ClassTile extends StatelessWidget {
  const ClassTile(this.classe);

  final Class classe;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(classe.id),
      title: Text(classe.name),
      onTap: () => ALRouter.push(context, ClassHomeScreen(classe)),
      trailing: ClassActions(classe),
    );
  }
}

class ClassActions extends StatelessWidget {
  const ClassActions(this.classe);

  final Class classe;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: <Widget>[
        GGCircleButton(
          icon: Icons.edit,
          colorIcon: Colors.white,
          colorButton: Colors.blue[600],
          onTap: () => navigateToEdit(context, classe),
        ),
        GGCircleButton(
          icon: Icons.delete,
          colorIcon: Colors.white,
          colorButton: Colors.red[600],
          onTap: () => GGDialog.show(
            context,
            GGConfirmDeleteDialog(
              title: 'Remover turma?',
              onClickYes: () async =>
                  await BlocProvider.getBloc<ListClassesBloc>()
                      .delete(classe.id),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> navigateToEdit(BuildContext context, Class classe) async {
    final Class classToSave =
        await ALRouter.push(context, SaveClassScreen(classe));
    if (classToSave != null) {
      await BlocProvider.getBloc<ListClassesBloc>().save(classToSave);
    }
  }
}
