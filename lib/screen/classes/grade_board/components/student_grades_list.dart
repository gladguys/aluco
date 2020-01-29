import 'package:aluco/model/exams_period.dart';
import 'package:aluco/model/period_content.dart';
import 'package:aluco/utils/al_number_format.dart';
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
          activeBgColor: Theme.of(context).primaryColor,
          activeTextColor: Colors.white,
          inactiveBgColor: Theme.of(context).primaryColor.withOpacity(0.2),
          inactiveTextColor: Colors.grey[850],
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
        const SizedBox(height: 4),
        Material(
          color: Colors.grey[100],
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey[200]),
          ),
          child: _buildPeriodContent(allPeriodsContent[index].examsPeriod ?? [],
              allPeriodsContent[index].average),
        ),
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
                allPeriodsContent[index].examsPeriod[i].grade != null
                    ? ALNumberFormat.formatDoubleWithDecimal(
                        number: allPeriodsContent[index]
                            .examsPeriod[i]
                            .grade
                            .toString())
                    : 'Sem Nota',
                style: TextStyle(
                  fontSize: 16,
                  color: allPeriodsContent[index].examsPeriod[i].grade != null && 
                          allPeriodsContent[index].examsPeriod[i].grade >= 6
                      ? Colors.green[600]
                      : Colors.red[600],
                ),
              ),
            );
          } else {
            return Material(
              color: Colors.grey[200],
              child: ListTile(
                title: const Text(
                  'Média do Bimestre',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                trailing: Text(
                  ALNumberFormat.formatDoubleWithDecimal(
                          number:
                              allPeriodsContent[index].average?.toString()) ??
                      'Sem Média',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: allPeriodsContent[index].average >= 6
                        ? Colors.green[600]
                        : Colors.red[600],
                  ),
                ),
              ),
            );
          }
        },
        itemCount: (allPeriodsContent[index].examsPeriod?.isEmpty ?? true)
            ? 0
            : allPeriodsContent[index].examsPeriod.length + 1,
      );
    } else {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Não existem provas para este bimestre',
          ),
        ),
      );
    }
  }
}
