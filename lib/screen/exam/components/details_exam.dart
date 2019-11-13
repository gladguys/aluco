import 'package:aluco/model/exam.dart';
import 'package:flutter/material.dart';

class DetailsExam extends StatelessWidget {
  const DetailsExam(this.exam);

  final Exam exam;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text('Prova: '),
              const SizedBox(width: 12),
              Text(exam.name ?? ''),
            ],
          ),
          Row(
            children: <Widget>[
              const Text('Descrição: '),
              const SizedBox(width: 12),
              Text(exam.description ?? ''),
            ],
          ),
          Row(
            children: <Widget>[
              const Text('Peso: '),
              const SizedBox(width: 12),
              Text(exam.weight?.toString() ?? ''),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.calendar_today),
              const SizedBox(width: 8),
              const Text('Data de Aplicação: '),
              const SizedBox(width: 12),
              Text(exam.examDate?.toString() ?? ''),
            ],
          ),
        ],
      ),
    );
  }
}
