import 'package:aluco/enums/call_status.dart';
import 'package:aluco/model/student_call.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gg_flutter_components/form/gg_form_datepicker.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'call_bloc.dart';

class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  CallBloc _callBloc;
  ClassHomeBloc _classHomeBloc;

  @override
  void initState() {
    _callBloc = BlocProvider.getBloc<CallBloc>();
    _classHomeBloc = BlocProvider.getBloc<ClassHomeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Fazer Chamada',
      subtitle: _classHomeBloc.pickedClass.name,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: 210,
                child: GGFormDatePicker(
                    format: _callBloc.dateFormat,
                    labelText: 'Data',
                    initialDate: DateTime.now(),
                    onChanged: (callDate) {
                      if (callDate != null) {
                        _callBloc.initializeClassStudentsFromDate(
                            _classHomeBloc.pickedClass.id, callDate);
                      }
                    }),
              ),
              const SizedBox(height: 16),
              StreamBuilder<List<StudentCall>>(
                stream: _callBloc.studentsCallController.stream,
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    final students = snapshot.data;
                    return ListView.separated(
                      padding: const EdgeInsets.only(bottom: 80),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, i) => StudentCallItem(students[i]),
                      separatorBuilder: (_, i) => const SizedBox(height: 8),
                      itemCount: students.length,
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentCallItem extends StatelessWidget {
  StudentCallItem(this.studentCall);

  final StudentCall studentCall;
  final CallBloc _callBloc = BlocProvider.getBloc<CallBloc>();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(studentCall.studentName ?? ''),
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
                const Text('Faltas: 00'),
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
