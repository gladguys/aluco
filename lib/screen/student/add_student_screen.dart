import 'package:aluco/enums/gender.dart';
import 'package:aluco/model/student.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/utils/form_utils.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:avataaar_image/avataaar_image.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

import 'student_bloc.dart';

class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> with GGValidators {
  final _formKey = GlobalKey<FormState>();
  final _student = Student();
  final _bloc = StudentBloc();

  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Adicionar Aluno',
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () async {
            final form = _formKey.currentState;
            if (FormUtils.isValid(form)) {
              form.save();
              print(_student);
              await _bloc.saveStudent(_student);
              ALRouter.pop(context);
            }
          },
        ),
      ],
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 18),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: AvataaarImage(
              avatar: Avataaar.random(),
              errorImage: Icon(Icons.error),
              placeholder: const CircularProgressIndicator(),
            ),
          ),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    // TODO(rodrigo): transform in a component in GGFC
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text('Masculino'),
                        Switch(
                          value: _student.gender?.index == 0 ?? true,
                          onChanged: (value) {
                            setState(() {
                              if (_student.gender == Gender.male) {
                                _student.gender = Gender.female;
                              } else {
                                _student.gender = Gender.male;
                              }
                            });
                          },
                        ),
                        const Text('Feminino'),
                      ],
                    ),
                    FormVerticalSeparator,
                    TextFormField(
                      onSaved: (name) => _student.name = name,
                      validator: emptyValidator,
                      decoration: InputDecoration(
                        labelText: 'Nome Completo *',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    FormVerticalSeparator,
                    TextFormField(
                      onSaved: (phone) => _student.phone = phone,
                      decoration: InputDecoration(
                        labelText: 'Telefone',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    FormVerticalSeparator,
                    TextFormField(
                      onSaved: (email) => _student.email = email,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    FormVerticalSeparator,
                    TextFormField(
                      onSaved: (responsibleName) =>
                          _student.responsibleName = responsibleName,
                      decoration: InputDecoration(
                        labelText: 'Nome do Responsável',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    FormVerticalSeparator,
                    TextFormField(
                      onSaved: (responsiblePhone) =>
                          _student.responsiblePhone = responsiblePhone,
                      decoration: InputDecoration(
                        labelText: 'Telefone do Responsável',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    FormVerticalSeparator,
                    TextFormField(
                      onSaved: (address) => _student.address = address,
                      decoration: InputDecoration(
                        labelText: 'Endereço Completo',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    FormVerticalSeparator,
                    TextFormField(
                      onSaved: (previousSchool) =>
                          _student.previousSchool = previousSchool,
                      decoration: InputDecoration(
                        labelText: 'Escola Anterior',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    FormVerticalSeparator,
                    TextFormField(
                      maxLines: 3,
                      minLines: 3,
                      onSaved: (observation) =>
                          _student.observation = observation,
                      decoration: InputDecoration(
                        labelText: 'Observação',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
