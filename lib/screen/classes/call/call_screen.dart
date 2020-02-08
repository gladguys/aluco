import 'package:aluco/model/student_call.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
import 'package:aluco/screen/classes/class_home/class_students/components/add_student_class_button.dart';
import 'package:aluco/theme/main_theme.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:aluco/widget/gg_form_date_picker.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:gg_flutter_components/validator/gg_validators.dart';
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 205,
                    child: GGFormDatePicker(
                      format: _callBloc.dateFormat,
                      labelText: 'Data',
                      initialDate: DateTime.now(),
                      onChanged: (callDate) {
                        _callBloc.dateController.add(callDate);
                        pickedDate = callDate;
                        if (callDate != null) {
                          _callBloc.initializeClassStudentsFromDate(
                              _classHomeBloc.pickedClass.id, callDate);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  StreamBuilder<DateTime>(
                      stream: _callBloc.dateController.stream,
                      initialData: DateTime.now(),
                      builder: (_, snapshot) {
                        if (snapshot.data == null) {
                          return const SizedBox();
                        }
                        return snapshot.data
                                        .difference(DateTime.now())
                                        .inHours <
                                    24 &&
                                _callBloc.dateController.value.day ==
                                    DateTime.now().day
                            ? OutlineButton.icon(
                                icon: Icon(
                                  FontAwesome5.getIconData(
                                    'paper-plane',
                                    weight: IconWeight.Solid,
                                  ),
                                  size: 16,
                                ),
                                label: const Text('Enviar \npor email'),
                                color: theme.primaryColor,
                                textColor: theme.primaryColorDark,
                                highlightedBorderColor: theme.primaryColor,
                                borderSide:
                                    BorderSide(color: theme.primaryColor),
                                padding: const EdgeInsets.all(8),
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: 'Enviar relatório para email:',
                                    content: Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        validator: requiredEmailValidator,
                                        onSaved: (email) async {
                                          await _callBloc.sendDailyCall(
                                              _classHomeBloc.pickedClass.id,
                                              email);
                                          Get.back();
                                          GGSnackbar.success(
                                            message:
                                                'Notas enviadas com sucesso!',
                                            context: context,
                                          );
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'E-mail',
                                          prefixIcon: Icon(Icons.email),
                                          border: const OutlineInputBorder(),
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
                              )
                            : const SizedBox();
                      }),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: StreamBuilder<List<StudentCall>>(
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
                          itemBuilder: (_, i) =>
                              StudentCallItem(students[i], i),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
