import 'package:aluco/enums/gender.dart';
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/user120.png',
              fit: BoxFit.cover,
              width: 120,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            student.name ?? '',
            maxLines: 4,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Responsável:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                student.responsibleName ?? '',
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Endereço:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                student.address ?? '',
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'E-mail:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                student.email ?? '',
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Data de Nascimento:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                student.dateBirth ?? '',
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Gênero:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                _getGender(student.gender) ?? '',
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getGender(Gender gender) {
    if (gender != null) {
      if (gender == Gender.male) {
        return 'Masculino';
      }
      return 'Feminino';
    }
    return null;
  }
}
