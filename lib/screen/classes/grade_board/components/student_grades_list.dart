import 'package:aluco/model/period_content.dart';
import 'package:flutter/material.dart';

class StudentGradesList extends StatelessWidget {
  const StudentGradesList(this.allPeriodsContent);

  final List<PeriodContent> allPeriodsContent;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (_, i) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            //child: Text(exams[i].examName),
            child: Text(''),
          ),
          const SizedBox(width: 8),
          /*if (exams[i].grade != null)
            Text(
              ALNumberFormat.formatDoubleWithDecimal(
                number: exams[i].grade.toString(),
              ),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color:
                    exams[i].grade >= 6 ? Colors.green[600] : Colors.red[600],
              ),
            )
          else
            const Text(
              'Sem Nota',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),*/
        ],
      ),
      separatorBuilder: (_, i) => const Divider(),
      itemCount: 0,
    );
  }
}
