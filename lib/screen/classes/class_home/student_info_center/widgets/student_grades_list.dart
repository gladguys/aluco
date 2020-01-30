import 'package:aluco/model/exams_period.dart';
import 'package:aluco/model/period_content.dart';
import 'package:aluco/model/student_grades.dart';
import 'package:aluco/utils/al_number_format.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class StudentGradesList extends StatefulWidget {
  const StudentGradesList(this.studentGrades);

  final StudentGrades studentGrades;

  @override
  _StudentGradesListState createState() => _StudentGradesListState();
}

class _StudentGradesListState extends State<StudentGradesList> {
  int index;
  StudentGrades get studentGrades => widget.studentGrades;

  @override
  void initState() {
    index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ToggleSwitch(
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
        ),
        const SizedBox(height: 4),
        Material(
          color: Colors.grey[100],
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey[200]),
          ),
          child: _buildPeriodGrades(studentGrades.allPeriodsContent[index]),
        ),
      ],
    );
  }

  Widget _buildPeriodGrades(PeriodContent periodContent) {
    if (periodContent.examsPeriod != null &&
        periodContent.examsPeriod.isNotEmpty) {
      return Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (_, i) => ExamTile(periodContent.examsPeriod[i]),
            itemCount: periodContent.examsPeriod.length,
          ),
          Material(
            color: Colors.grey[200],
            child: ListTile(
              title: const Text(
                'Média do Bimestre:',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              trailing: Text(
                periodContent.average != null
                    ? ALNumberFormat.formatDoubleWithDecimal(
                        number: periodContent.average.toString())
                    : 'Sem média',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: periodContent.average == null
                      ? Colors.grey
                      : periodContent.average >= 6
                          ? Colors.green[600]
                          : Colors.red[600],
                ),
              ),
            ),
          ),
        ],
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

class ExamTile extends StatelessWidget {
  const ExamTile(this.examsPeriod);

  final ExamsPeriod examsPeriod;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        examsPeriod.examName,
        style: TextStyle(
          color: examsPeriod.recExam ? Colors.lightBlue : Colors.black,
        ),
      ),
      trailing: Text(
        examsPeriod.grade != null
            ? ALNumberFormat.formatDoubleWithDecimal(
                number: examsPeriod.grade.toString())
            : 'Sem nota',
        style: TextStyle(
          fontSize: 16,
          color: examsPeriod.grade == null
              ? Colors.grey
              : (examsPeriod.grade >= 6 ? Colors.green[600] : Colors.red[600]),
        ),
      ),
    );
  }
}
