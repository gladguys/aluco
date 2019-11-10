import 'package:aluco/model/class.dart';
import 'package:flutter/material.dart';

import 'class_tile.dart';

class ListClasses extends StatelessWidget {
  const ListClasses(this.classes);

  final List<Class> classes;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == classes.length - 1) {
            return Column(
              children: <Widget>[
                ClassTile(classes[index]),
                const SizedBox(height: 80),
              ],
            );
          }
          return Column(
            children: <Widget>[
              ClassTile(classes[index]),
              const Divider(height: 1),
            ],
          );
        },
        childCount: classes.length,
      ),
    );
  }
}
