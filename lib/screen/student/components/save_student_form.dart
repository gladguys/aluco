import 'package:aluco/enums/gender.dart' as our_gender;
import 'package:aluco/model/student.dart';
import 'package:aluco/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/form/gg_form_datepicker.dart';
import 'package:gg_flutter_components/form/gg_outlined_text_form_field.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';
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
  final dateFormat = DateFormat('dd-MM-yyyy');

  final dataNascimentoFN = FocusNode();
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
      _student = Student()..gender = our_gender.Gender.male;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              FormVerticalSeparatorMedium,
              GGOutlinedTextFormField(
                labelText: 'Nome Completo *',
                initialValue: _student.name,
                textInputAction: TextInputAction.done,
                onSaved: (name) => _student.name = name,
                validator: emptyValidator,
              ),
              FormVerticalSeparator,
              GGFormDatePicker(
                labelText: 'Data de Nascimento',
                format: dateFormat,
                focusNode: dataNascimentoFN,
                initialDate: _student.dateBirth != null ? dateFormat.parse(_student.dateBirth) : null,
                onChanged: (birthdayDate) {
                  if (birthdayDate != null) {
                    _student.dateBirth = dateFormat?.format(birthdayDate);
                  }
                },
              ),
              FormVerticalSeparator,
              // const Text('Sexo'),
              Wrap(
                children: <Widget>[
                  Row(
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
                  const SizedBox(width: 8),
                  Row(
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
                ],
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Telefone',
                initialValue: _student.phone,
                focusNode: phoneFN,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(emailFN),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                onSaved: (phone) => _student.phone = phone,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'E-mail',
                initialValue: _student.email,
                focusNode: emailFN,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(responsibleNameFN),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
                onSaved: (email) => _student.email = email,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Nome do Responsável',
                initialValue: _student.responsibleName,
                focusNode: responsibleNameFN,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(responsiblePhoneFN),
                textInputAction: TextInputAction.next,
                onSaved: (responsibleName) =>
                    _student.responsibleName = responsibleName,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Telefone do Responsável',
                initialValue: _student.responsiblePhone,
                focusNode: responsiblePhoneFN,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(addressFN),
                textInputAction: TextInputAction.next,
                onSaved: (responsiblePhone) =>
                    _student.responsiblePhone = responsiblePhone,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Endereço Completo',
                initialValue: _student.address,
                focusNode: addressFN,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(previousSchooleFN),
                textInputAction: TextInputAction.next,
                onSaved: (address) => _student.address = address,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Escola Anterior',
                initialValue: _student.previousSchool,
                focusNode: previousSchooleFN,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(observationFN),
                textInputAction: TextInputAction.next,
                onSaved: (previousSchool) =>
                    _student.previousSchool = previousSchool,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Observação',
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
