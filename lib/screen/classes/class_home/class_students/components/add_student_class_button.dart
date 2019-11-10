import 'package:aluco/widget/delegate/add_student_class_search_delegate.dart';
import 'package:flutter/material.dart';

class AddStudentClassButton extends StatelessWidget {
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
        await showSearch(
            context: context, delegate: AddStudentClassSearchDelegate());
      },
    );
  }
}
