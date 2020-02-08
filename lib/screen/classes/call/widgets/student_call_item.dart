import 'package:aluco/enums/call_status.dart';
import 'package:aluco/model/student_absence.dart';
import 'package:aluco/model/student_call.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../call_bloc.dart';

class StudentCallItem extends StatelessWidget {
  StudentCallItem(this.studentCall, this.index);

  final StudentCall studentCall;
  final int index;
  final CallBloc _callBloc = BlocProvider.getBloc<CallBloc>();

  @override
  Widget build(BuildContext context) {
    return Material(
      key: ValueKey(studentCall.studentId),
      color: Colors.white,
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey[200]),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(studentCall.numberCall != null 
            ? (studentCall.numberCall.toString() +'. '+ studentCall.studentName ?? '')
            : studentCall.studentName ?? ''),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Material(
              elevation: .4,
              borderRadius: BorderRadius.circular(20),
              child: ToggleSwitch(
                minWidth: 85,
                cornerRadius: 20,
                initialLabelIndex: getIntFromCallStatus(studentCall.status),
                activeColors: [
                  Colors.green[600],
                  Colors.red[600],
                  Colors.amber[700],
                ],
                activeBgColor: Colors.transparent,
                activeTextColor: Colors.white,
                inactiveBgColor: Colors.grey[200],
                inactiveTextColor: Colors.grey[900],
                labels: const ['Presente', 'Faltou', 'Justificou'],
                onToggle: (pickedIndex) async => _callBloc
                    .handleStudentCallChanged(studentCall, pickedIndex),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                StreamBuilder<StudentAbsence>(
                  stream:
                      _callBloc.getStudentAbsence(studentCall.studentId).stream,
                  builder: (_, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final studentAbsence = snapshot.data;
                      return Text(
                          'Faltas: ${studentAbsence.qtAbsences ?? '0'}');
                    }
                    return const Text('Faltas: --');
                  },
                ),
                const SizedBox(width: 4),
                Icon(
                  FontAwesome5.getIconData(
                    'exclamation-triangle',
                    weight: IconWeight.Solid,
                  ),
                  size: 18,
                  color: Colors.amber[600],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
