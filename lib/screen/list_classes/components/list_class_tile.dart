import 'package:aluco/model/class.dart';
import 'package:flutter/material.dart';

class ListClassTile extends StatelessWidget {
  const ListClassTile(this.classe);

  final Class classe;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(classe.name),
    );
  }
}
