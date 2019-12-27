import 'package:aluco/model/student_call.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/form/gg_form_datepicker.dart';

import 'call_bloc.dart';
import 'widgets/student_call_item.dart';

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