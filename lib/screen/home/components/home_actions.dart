import 'package:aluco/routing/al_router.dart';
import 'package:aluco/screen/list_classes/list_classes_screen.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

class HomeActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (_, i) => GGIconContainer(
          icon: Icon(actions[i]['icon'], size: 60),
          text: Text(actions[i]['text'], style: TextStyle(fontSize: 22),),
          onTap: () => ALRouter.push(context, actions[i]['target']),
        ),
        itemCount: actions.length,
      ),
    );
  }
}

final actions = [
  {
    'icon': Icons.class_,
    'text': 'Minhas Turmas',
    'target': ListClassesScreen()
  },
  {
    'icon': Icons.add_circle_outline,
    'text': 'Criar Turma',
    'target': null
  },
  {
    'icon': Icons.school,
    'text': 'Criar Aluno',
    'target': null
  },
];