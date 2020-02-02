import 'package:aluco/enums/gender.dart' as our_gender;
import 'package:aluco/model/student.dart';
import 'package:aluco/widget/gg_form_date_picker.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/form/gg_outlined_text_form_field.dart';
import 'package:gg_flutter_components/validator/gg_validators.dart';
import 'package:intl/intl.dart';

class SaveStudentForm extends StatefulWidget {
  SaveStudentForm(this.student);

  final Student student;

  FormState get form => _saveStudentState._formKey.currentState;
  Student get studentForm => _saveStudentState._student;

  final _saveStudentState = _SaveStudentFormState();

  @override
  _SaveStudentFormState createState() => _saveStudentState;
}

class _SaveStudentFormState extends State<SaveStudentForm> with GGValidators {
  final _formKey = GlobalKey<FormState>();
  final dateFormat = DateFormat('dd/MM/yyyy');

  final registrationNumberFN = FocusNode();
  final birthDateFN = FocusNode();
  final phoneFN = FocusNode();
  final emailFN = FocusNode();
  final responsibleNameFN = FocusNode();
  final responsiblePhoneFN = FocusNode();
  final addressFN = FocusNode();
  final previousSchooleFN = FocusNode();
  final observationFN = FocusNode();

  Student _student;

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _student = widget.student;
    } else {
      _student = Student()
        ..gender = our_gender.Gender.male
        ..aee = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/user120.png',
                    fit: BoxFit.cover,
                    width: 120,
                  ),
                ],
              ),
              GGOutlinedTextFormField(
                labelText: 'Matrícula *',
                width: 150,
                initialValue: _student.registrationNumber,
                textInputAction: TextInputAction.done,
                onSaved: (registrationNumber) =>
                    _student.registrationNumber = registrationNumber,
                validator: emptyValidator,
              ),
              GGOutlinedTextFormField(
                labelText: 'Nome Completo *',
                width: 300,
                initialValue: _student.name,
                textInputAction: TextInputAction.done,
                onSaved: (name) => _student.name = name,
                validator: emptyValidator,
              ),
              Container(
                height: 60,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularCheckBox(
                      value: _student.aee,
                      onChanged: (aee) {
                        setState(() {
                          _student.aee = aee;
                        });
                        _student.aee = aee;
                      },
                      activeColor: Theme.of(context).primaryColor,
                    ),
                    const Text('AEE? '),
                  ],
                ),
              ),
              GGFormDatePicker(
                labelText: 'Data de Nascimento',
                width: 280,
                format: dateFormat,
                focusNode: birthDateFN,
                initialDate: _student.dateBirth != null
                    ? dateFormat.parse(_student.dateBirth)
                    : null,
                onChanged: (birthdayDate) {
                  if (birthdayDate != null) {
                    _student.dateBirth = dateFormat?.format(birthdayDate);
                  }
                },
              ),
              Wrap(
                spacing: 8,
                children: <Widget>[
                  Container(
                    height: 60,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Radio(
                          groupValue: _student.gender,
                          value: our_gender.Gender.male,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (Object object) {
                            setState(() {
                              _student.gender = our_gender.Gender.male;
                            });
                          },
                        ),
                        const Text('Masculino'),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Radio(
                          groupValue: _student.gender,
                          value: our_gender.Gender.female,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (Object object) {
                            setState(() {
                              _student.gender = our_gender.Gender.female;
                            });
                          },
                        ),
                        const Text('Feminino'),
                      ],
                    ),
                  ),
                ],
              ),
              GGOutlinedTextFormField(
                labelText: 'Telefone',
                width: 150,
                initialValue: _student.phone,
                focusNode: phoneFN,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(emailFN),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                onSaved: (phone) => _student.phone = phone,
              ),
              GGOutlinedTextFormField(
                labelText: 'E-mail',
                width: 300,
                initialValue: _student.email,
                focusNode: emailFN,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(responsibleNameFN),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
                onSaved: (email) => _student.email = email,
              ),
              GGOutlinedTextFormField(
                labelText: 'Nome do Responsável',
                width: 300,
                initialValue: _student.responsibleName,
                focusNode: responsibleNameFN,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(responsiblePhoneFN),
                textInputAction: TextInputAction.next,
                onSaved: (responsibleName) =>
                    _student.responsibleName = responsibleName,
              ),
              GGOutlinedTextFormField(
                labelText: 'Telefone do Responsável',
                width: 230,
                initialValue: _student.responsiblePhone,
                focusNode: responsiblePhoneFN,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(addressFN),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                onSaved: (responsiblePhone) =>
                    _student.responsiblePhone = responsiblePhone,
              ),
              GGOutlinedTextFormField(
                labelText: 'Endereço Completo',
                width: 400,
                initialValue: _student.address,
                focusNode: addressFN,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(previousSchooleFN),
                textInputAction: TextInputAction.next,
                onSaved: (address) => _student.address = address,
              ),
              GGOutlinedTextFormField(
                labelText: 'Escola Anterior',
                width: 400,
                initialValue: _student.previousSchool,
                focusNode: previousSchooleFN,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(observationFN),
                textInputAction: TextInputAction.next,
                onSaved: (previousSchool) =>
                    _student.previousSchool = previousSchool,
              ),
              GGOutlinedTextFormField(
                labelText: 'Observação',
                width: 400,
                initialValue: _student.observation,
                focusNode: observationFN,
                textInputAction: TextInputAction.done,
                onSaved: (observation) => _student.observation = observation,
                minLines: 3,
                maxLines: 3,
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
