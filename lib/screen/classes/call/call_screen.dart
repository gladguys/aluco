import 'package:aluco/model/student_call.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
import 'package:aluco/screen/classes/class_home/class_students/components/add_student_class_button.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gg_flutter_components/form/gg_form_datepicker.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';
import 'package:gg_flutter_components/gg_snackbar.dart';

import 'call_bloc.dart';
import 'widgets/student_call_item.dart';

class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> with GGValidators {
  CallBloc _callBloc;
  ClassHomeBloc _classHomeBloc;
  GlobalKey<FormState> _formKey;
  DateTime pickedDate;

  @override
  void initState() {
    _callBloc = BlocProvider.getBloc<CallBloc>();
    _classHomeBloc = BlocProvider.getBloc<ClassHomeBloc>();
    _formKey = GlobalKey<FormState>();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 210,
                    child: GGFormDatePicker(
                      format: _callBloc.dateFormat,
                      labelText: 'Data',
                      initialDate: DateTime.now(),
                      onChanged: (callDate) {
                        pickedDate = callDate;
                        if (callDate != null) {
                          _callBloc.initializeClassStudentsFromDate(
                              _classHomeBloc.pickedClass.id, callDate);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  RaisedButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'Enviar relatório para email:',
                        content: Form(
                          key: _formKey,
                          child: TextFormField(
                            validator: requiredEmailValidator,
                            onSaved: (email) async {
                              await _callBloc.sendDailyCall(
                                  _classHomeBloc.pickedClass.id, email);
                              Get.back();
                              GGSnackbar.success(
                                message: 'Notas enviadas com sucesso!',
                                context: context,
                              );
                            },
                            decoration: InputDecoration(
                              hintText: 'E-mail',
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        confirm: FlatButton(
                          child: const Text('Enviar'),
                          onPressed: () {
                            final form = _formKey.currentState;
                            if (form.validate()) {
                              form.save();
                            }
                          },
                        ),
                        cancel: FlatButton(
                          child: const Text('Cancelar'),
                          onPressed: () => Get.back(),
                        ),
                      );
                    },
                    child: const Text('Enviar'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              StreamBuilder<List<StudentCall>>(
                stream: _callBloc.studentsCallController.stream,
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    final students = snapshot.data;
                    if (students.isNotEmpty) {
                      return ListView.separated(
                        key: Key(pickedDate?.toString()),
                        padding: const EdgeInsets.only(bottom: 80),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (_, i) => StudentCallItem(students[i]),
                        separatorBuilder: (_, i) => const SizedBox(height: 8),
                        itemCount: students.length,
                      );
                    } else {
                      return Column(
                        children: const <Widget>[
                          SizedBox(height: 48),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              'Você ainda não adicionou nenhum aluno a esta turma.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 48),
                          AddStudentClassButton(isFloating: false),
                          SizedBox(height: 8),
                        ],
                      );
                    }
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
