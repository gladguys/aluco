import 'package:aluco/model/class.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/screen/classes/class_home/class_home_connected_screen.dart';
import 'package:aluco/screen/classes/class_home/class_home_screen.dart';
import 'package:aluco/screen/classes/list_classes/list_classes_bloc.dart';
import 'package:aluco/screen/classes/list_classes/save_class_screen.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => navigateToEdit(context, classe),
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => GGDialog.show(
            context,
            GGConfirmDeleteDialog(
              title: 'Remover estudante?',
              onClickYes: () async =>
              await BlocProvider.of<ListClassesBloc>(context).delete(classe.id),
            ),
          ),
        )
      ],
    );
  }

  Future<void> navigateToEdit(BuildContext context, Class classe) async {
    final _bloc = BlocProvider.of<ListClassesBloc>(context);
    final Class classToSave =
    await ALRouter.push(context, SaveClassScreen(classe));
    if (classToSave != null) {
      await _bloc.save(classToSave);
    }
  }
}
