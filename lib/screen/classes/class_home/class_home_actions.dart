import 'package:aluco/screen/classes/class_home/class_students/class_students_screen.dart';
import 'package:aluco/screen/student/list_students_screen.dart';
import 'package:aluco/widget/al_icon_text_vertical_button.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ClassHomeActions extends StatelessWidget {
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
              ALIconTextVerticalButton(
                icon: Ionicons.getIconData('ios-people'),
                text: 'Alunos da Turma',
                route: ClassStudentsScreen(),
              ),
              ALIconTextVerticalButton(
                icon: Foundation.getIconData('clipboard-notes'),
                text: 'Histórico de Chamadas',
                route: ListStudentsScreen(),
              ),
              ALIconTextVerticalButton(
                icon: MaterialIcons.getIconData('grade'),
                text: 'Quadro de Notas',
                route: ListStudentsScreen(),
              ),
              ALIconTextVerticalButton(
                icon: Entypo.getIconData('open-book'),
                text: 'Planos de Aulas',
                route: ListStudentsScreen(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}