import 'package:aluco/widget/delegate/add_student_class_search_delegate.dart';
import 'package:aluco/theme/main_theme.dart';
import 'package:flutter/material.dart';

class AddStudentClassButton extends StatelessWidget {
  const AddStudentClassButton({this.isFloating = true});

  final bool isFloating;

  @override
  Widget build(BuildContext context) {
    return isFloating ? _buildFab(context) : _buildOutlineButton(context);
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: const Text(
        'Adicionar',
        style: TextStyle(
          fontSize: 16,
          letterSpacing: 0,
        ),
      ),
      backgroundColor: theme.primaryColor,
      foregroundColor: theme.accentColor,
      onPressed: _onPressed(context),
    );
  }

  Widget _buildOutlineButton(BuildContext context) {
    return OutlineButton.icon(
      icon: Icon(Icons.add, size: 26),
      label: const Text(
        'Adicionar',
        style: TextStyle(
          fontSize: 18,
          letterSpacing: 0,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      color: theme.primaryColor,
      textColor: theme.primaryColorDark,
      highlightedBorderColor: theme.primaryColor,
      borderSide: BorderSide(color: theme.primaryColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onPressed: _onPressed(context),
    );
  }

  Function _onPressed(BuildContext context) {
    return () async {
      await showSearch(
          context: context, delegate: AddStudentClassSearchDelegate());
    };
  }
}
