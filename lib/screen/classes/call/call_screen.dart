import 'package:aluco/enums/call_status.dart';
import 'package:aluco/model/student_call.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
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
    final students = _callBloc.studentsCallController.value;
    return ALScaffold(
      title: 'Fazer Chamada',
      subtitle: _classHomeBloc.pickedClass.name,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GGFormDatePicker(
                format: _callBloc.dateFormat,
                labelText: 'Data',
                initialDate: DateTime.now(),
              ),
              const SizedBox(height: 36),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, i) => StudentCallItem(students[i]),
                separatorBuilder: (_, i) => const Divider(),
                itemCount: students.length,
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
    return Column(
      children: <Widget>[
        Text(studentCall.studentId.toString()),
        const SizedBox(height: 12),
        ToggleSwitch(
          minWidth: 90.0,
          initialLabelIndex: getIntFromCallStatus(studentCall.status),
          activeColors: [
            Colors.green,
            Colors.red,
            Colors.blue,
          ],
          activeBgColor: Colors.redAccent,
          activeTextColor: Colors.white,
          inactiveBgColor: Colors.grey[300],
          inactiveTextColor: Colors.grey[900],
          labels: const ['Presente', 'Faltou', 'Justificou'],
          onToggle: (pickedIndex) async =>
              _callBloc.handleStudentCallChanged(studentCall, pickedIndex),
        ),
        const SizedBox(height: 12),
        const Text('Faltas: NOT DONE YET'),
      ],
    );
  }
}
