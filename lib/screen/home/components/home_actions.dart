import 'package:aluco/routing/al_router.dart';
import 'package:aluco/screen/classes/list_classes/list_classes_screen.dart';
import 'package:aluco/screen/student/list_students_screen.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

class HomeActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            children: <Widget>[
              _buildButton(
                icon: Icons.people,
                text: 'Turmas',
                route: ListClassesScreen(),
                context: context,
              ),
              _buildButton(
                icon: Icons.school,
                text: 'Alunos',
                route: ListStudentsScreen(),
                context: context,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    IconData icon,
    String text,
    Widget route,
    BuildContext context,
  }) {
    final ThemeData theme = Theme.of(context);
    return GGIconLabelContainer(
      icon: Icon(
        icon,
        size: 60,
        color: theme.accentColor,
      ),
      text: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: theme.accentColor,
        ),
      ),
      width: 140,
      height: 120,
      backgroundColor: Colors.white,
      borderWidth: 1,
      withShadow: true,
      onTap: () => ALRouter.push(context, route),
    );
  }
}
