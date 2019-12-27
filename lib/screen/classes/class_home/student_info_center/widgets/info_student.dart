import 'package:aluco/model/student.dart';
import 'package:flutter/material.dart';

class InfoStudent extends StatelessWidget {
  const InfoStudent(this.student);

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'Nome',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                student.name ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              'Responsável',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                student.responsibleName ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              'Endereço',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                student.address ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              'E-mail',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                student.email ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              'Data de Nascimento',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                student.dateBirth ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              'Gênero',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                student.gender?.toString() ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
