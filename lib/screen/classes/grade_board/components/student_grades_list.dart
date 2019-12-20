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
        Material(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ToggleSwitch(
              minWidth: 90,
              initialLabelIndex: 0,
              cornerRadius: 0,
              activeBgColor: Theme.of(context).primaryColor,
              activeTextColor: Colors.white,
              inactiveBgColor: Colors.white,
              inactiveTextColor: Theme.of(context).primaryColor,
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
          ),
        ),
        const SizedBox(height: 4),
        Material(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.grey[300],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: _buildPeriodContent(
            allPeriodsContent[index].examsPeriod ?? [],
            allPeriodsContent[index].average,
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodContent(
      List<ExamsPeriod> periodExams, double periodAverage) {
    if (periodExams.isNotEmpty) {
      return ListView.separated(
        separatorBuilder: (BuildContext context, int i) =>
            const Divider(height: 1),
        shrinkWrap: true,
        itemBuilder: (_, i) {
          if (i < allPeriodsContent[index].examsPeriod.length) {
            return ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              title: Text(
                allPeriodsContent[index].examsPeriod[i].examName,
                style: const TextStyle(fontSize: 14),
              ),
              trailing: Text(
                allPeriodsContent[index].examsPeriod[i].grade != null
                    ? ALNumberFormat.formatDoubleWithDecimal(
                        number:
                            '${allPeriodsContent[index].examsPeriod[i].grade}',
                      )
                    : 'Sem Nota',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: allPeriodsContent[index].examsPeriod[i].grade != null
                      ? allPeriodsContent[index].examsPeriod[i].grade >= 6
                          ? Colors.green[600]
                          : Colors.red[600]
                      : Colors.black,
                ),
              ),
            );
          } else {
            return Column(
              children: <Widget>[
                Container(
                  color: Colors.grey[200],
                  child: ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    title: const Text(
                      'Média do Bimestre',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Text(
                      allPeriodsContent[index].average != null
                          ? ALNumberFormat.formatDoubleWithDecimal(
                              number: '${allPeriodsContent[index].average}')
                          : 'Sem Média',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: allPeriodsContent[index].average != null
                            ? allPeriodsContent[index].average >= 6
                                ? Colors.green[600]
                                : Colors.red[600]
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
        itemCount: (allPeriodsContent[index].examsPeriod?.isEmpty ?? true)
            ? 0
            : allPeriodsContent[index].examsPeriod.length + 1,
      );
    } else {
      return ListTile(
        title: const Text(
          'Não existem provas para este bimestre.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
  }
}
