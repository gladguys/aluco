import 'package:aluco/model/class.dart';
import 'package:flutter/material.dart';

import 'class_tile.dart';

class ListClasses extends StatelessWidget {

  const ListClasses(this.classes);

  final List<Class> classes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: classes.length,
      itemBuilder: (_, i) {
        if (i == classes.length-1) {
          return Column(
            children: <Widget>[
              ClassTile(classes[i]),
              const SizedBox(height: 80),
            ],
          );
        }
        return ClassTile(classes[i]);
      },
      separatorBuilder: (_, i) => const Divider(height: 1),
    );
  }
}
