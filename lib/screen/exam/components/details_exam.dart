import 'package:aluco/model/exam.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsExam extends StatelessWidget {
  DetailsExam(this.exam);

  final Exam exam;
  final dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
            Wrap(
              runAlignment: WrapAlignment.center,
              children: <Widget>[
                Text(
                  exam.name ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              runAlignment: WrapAlignment.center,
              children: <Widget>[
                Text(
                  exam.description ?? '',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 90,
                  child: const Text(
                    'Aplicação: ',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 90,
                  child: Text(DateFormat('d MMM y', 'pt_br')
                          .format(dateFormat.parse(exam.examDate)) ??
                      ''),
                ),
              ],
            ),
            const SizedBox(height: 4),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Bimestre: ',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 4),
                  Text(exam.periodYear?.toString() ?? ''),
                  const SizedBox(width: 16),
                  const Text(
                    'Peso: ',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 4),
                  Text(exam.weight?.toString() ?? ''),
                  const SizedBox(width: 16),
                  const Text(
                    'Recuperação:',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 4),
                  Text(exam.recExam ? 'Sim' : 'Não'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
