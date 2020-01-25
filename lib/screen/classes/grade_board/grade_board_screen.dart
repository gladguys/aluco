import 'package:aluco/model/student_grades.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
import 'package:aluco/utils/al_number_format.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:aluco/widget/empty_state/grade_board_empty_state.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/loading/gg_loading_double_bounce.dart';

import 'components/student_grades_list.dart';
import 'grade_board_bloc.dart';

class GradeBoardScreen extends StatefulWidget {
  @override
  _GradeBoardScreenState createState() => _GradeBoardScreenState();
}

class _GradeBoardScreenState extends State<GradeBoardScreen> {
  Future<List<StudentGrades>> studentsGradeFuture;
  final _bloc = GradeBoardBloc();

  @override
  void initState() {
    final classId = BlocProvider.getBloc<ClassHomeBloc>().pickedClass.id;
    studentsGradeFuture = _bloc.getGradesBoard(classId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Quadro de Notas',
      body: FutureBuilder<List<StudentGrades>>(
        future: studentsGradeFuture,
        builder: (_, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const GGLoadingDoubleBounce();
            case ConnectionState.done:
              return snapshot.data.isNotEmpty
                  ? _list(snapshot.data)
                  : GradeBoardEmptyState();
            default:
              return const GGLoadingDoubleBounce();
          }
        },
      ),
    );
  }

  Widget _list(List<StudentGrades> studentsGrades) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 6);
      },
      itemCount: studentsGrades.length,
      itemBuilder: (_, i) {
        return Material(
          elevation: 1,
          clipBehavior: Clip.antiAlias,
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          child: ExpansionTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text('${studentsGrades[i].studentName}'),
                ),
                const SizedBox(width: 8),
                Column(
                  children: <Widget>[
                    const Text(
                      'Média',
                      style: TextStyle(fontSize: 9),
                    ),
                    Text(
                      ALNumberFormat.formatDoubleWithDecimal(
                        number: '${studentsGrades[i].average}',
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: studentsGrades[i].average >= 6
                            ? Colors.green[600]
                            : Colors.red[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: StudentGradesList(studentsGrades[i].allPeriodsContent),
              ),
            ],
          ),
        );
      },
    );
  }
}
