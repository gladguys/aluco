import 'package:aluco/model/class.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/dialog/gg_confirm_delete_dialog.dart';
import 'package:gg_flutter_components/dialog/gg_dialog.dart';

import '../class_bloc.dart';
import '../save_class_screen.dart';

class ClassTile extends StatelessWidget {
  const ClassTile(this.classe);

  final Class classe;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(classe.id),
      title: Text(classe.name),
      onTap: () => navigateToEdit(context, classe),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => GGDialog.show(
          context,
          GGConfirmDeleteDialog(
            title: 'Remover estudante?',
            onClickYes: () async =>
                await BlocProvider.of<ClassBloc>(context).delete(classe.id),
          ),
        ),
      ),
    );
  }

  Future<void> navigateToEdit(BuildContext context, Class classe) async {
    final _bloc = BlocProvider.of<ClassBloc>(context);
    final Class classToSave =
        await ALRouter.push(context, SaveClassScreen(classe));
    if (classToSave != null) {
      await _bloc.save(classToSave);
    }
  }
}
