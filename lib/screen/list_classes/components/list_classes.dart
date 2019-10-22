import 'package:aluco/model/class.dart';
import 'package:aluco/service/class_service.dart';
import 'package:aluco/widget/al_loading.dart';
import 'package:flutter/material.dart';

import 'list_class_tile.dart';

class ListClasses extends StatelessWidget {
  final _service = ClassService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Class>>(
      future: _service.getAllClasses(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          final classList = snapshot.data;
          return ListView.separated(
              itemCount: classList.length,
              itemBuilder: (_, i) => ListClassTile(classList[i]),
              separatorBuilder: (_, i) => const Divider(),
          );
        }
        return AlLoading();
      },
    );
  }
}
