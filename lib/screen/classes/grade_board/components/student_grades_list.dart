import 'package:aluco/model/exams_period.dart';
import 'package:aluco/model/period_content.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class StudentGradesList extends StatefulWidget {
  const StudentGradesList(this.allPeriodsContent);

  final List<PeriodContent> allPeriodsContent;

  @override
  _StudentGradesListState createState() => _StudentGradesListState();
}

class _StudentGradesListState extends State<StudentGradesList> {
  int index;
  List<PeriodContent> get allPeriodsContent => widget.allPeriodsContent;

  @override
  void initState() {
    index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ToggleSwitch(
          minWidth: 90.0,
          initialLabelIndex: 0,
          activeBgColor: Colors.redAccent,
          activeTextColor: Colors.white,
          inactiveBgColor: Colors.grey,
          inactiveTextColor: Colors.grey[900],
          labels: const [
            'Bimestre 1',
            'Bimestre 2',
            'Bimestre 3',
            'Bimestre 4'
          ],
          onToggle: (pickedIndex) {
            setState(() {
              index = pickedIndex;
            });
          },
        ),
        const SizedBox(height: 18),
        _buildPeriodContent(allPeriodsContent[index].examsPeriod ?? [],
            allPeriodsContent[index].average),
      ],
    );
  }

  Widget _buildPeriodContent(
      List<ExamsPeriod> periodExams, double periodAverage) {
    if (periodExams.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (_, i) {
          if (i < allPeriodsContent[index].examsPeriod.length) {
            return ListTile(
              title: Text(allPeriodsContent[index].examsPeriod[i].examName),
              trailing: Text(
                  allPeriodsContent[index].examsPeriod[i].grade?.toString() ??
                      'Sem Nota'),
            );
          } else {
            return ListTile(
              title: const Text('Média do Bimestre'),
              trailing: Text(
                  allPeriodsContent[index].average?.toString() ?? 'Sem Média'),
            );
          }
        },
        itemCount: (allPeriodsContent[index].examsPeriod?.isEmpty ?? true)
            ? 0
            : allPeriodsContent[index].examsPeriod.length + 1,
      );
    } else {
      return const Text(
        'Não existem provas para este bimestre',
        style: TextStyle(color: Colors.red),
      );
    }
  }
}
