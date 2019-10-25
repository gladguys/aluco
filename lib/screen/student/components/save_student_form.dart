import 'package:aluco/enums/gender.dart' as our_gender;
import 'package:aluco/model/student.dart';
import 'package:aluco/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:gender_selector/gender_selector.dart';
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
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              GenderSelector(
                margin: const EdgeInsets.all(10),
                maletxt: '',
                femaletxt: '',
                selectedGender: _student.gender == our_gender.Gender.male
                    ? Gender.MALE
                    : Gender.FEMALE,
                onChanged: (gender) {
                  setState(
                    () {
                      if (gender == Gender.MALE) {
                        _student.gender = our_gender.Gender.male;
                      } else {
                        _student.gender = our_gender.Gender.female;
                      }
                    },
                  );
                },
              ),
              GGOutlinedTextFormField(
                labelText: 'Nome Completo *',
                initialValue: _student.name,
                onSaved: (name) => _student.name = name,
                validator: emptyValidator,
              ),
              FormVerticalSeparator,
              GGFormDatePicker(
                labelText: 'Data de Nascimento',
                format: dateFormat,
                onSaved: (birthdayDate) {
                  if (birthdayDate != null) {
                    _student.dateBirth = dateFormat?.format(birthdayDate);
                  }
                }
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Telefone',
                initialValue: _student.phone,
                onSaved: (phone) => _student.phone = phone,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'E-mail',
                initialValue: _student.email,
                onSaved: (email) => _student.email = email,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Nome do Responsável',
                initialValue: _student.responsibleName,
                onSaved: (responsibleName) =>
                    _student.responsibleName = responsibleName,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Telefone do Responsável',
                initialValue: _student.responsiblePhone,
                onSaved: (responsiblePhone) =>
                    _student.responsiblePhone = responsiblePhone,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Endereço Completo',
                initialValue: _student.address,
                onSaved: (address) => _student.address = address,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Escola Anterior',
                initialValue: _student.previousSchool,
                onSaved: (previousSchool) =>
                    _student.previousSchool = previousSchool,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Observação',
                initialValue: _student.observation,
                onSaved: (observation) => _student.observation = observation,
                minLines: 3,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
