import 'package:aluco/enums/gender.dart' as our_gender;
import 'package:aluco/model/student.dart';
import 'package:aluco/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:gender_selector/gender_selector.dart';
import 'package:gg_flutter_components/form/gg_outlined_text_form_field.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

class AddStudentForm extends StatefulWidget {
  FormState get form => _addStudentState._formKey.currentState;
  Student get student => _addStudentState._student;

  final _addStudentState = _AddStudentFormState();

  @override
  _AddStudentFormState createState() => _addStudentState;
}

class _AddStudentFormState extends State<AddStudentForm> with GGValidators {
  final _formKey = GlobalKey<FormState>();

  Student _student;

  @override
  void initState() {
    super.initState();
    _student = Student()..gender = our_gender.Gender.male;
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
                  setState(() {
                    if (gender == Gender.MALE) {
                      _student.gender = our_gender.Gender.male;
                    } else {
                      _student.gender = our_gender.Gender.female;
                    }
                  });
                },
              ),
              GGOutlinedTextFormField(
                labelText: 'Nome Completo *',
                onSaved: (name) => _student.name = name,
                validator: emptyValidator,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Telefone',
                onSaved: (phone) => _student.phone = phone,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'E-mail',
                onSaved: (email) => _student.email = email,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Nome do Responsável',
                onSaved: (responsibleName) =>
                    _student.responsibleName = responsibleName,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Telefone do Responsável',
                onSaved: (responsiblePhone) =>
                    _student.responsiblePhone = responsiblePhone,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Endereço Completo',
                onSaved: (address) => _student.address = address,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Escola Anterior',
                onSaved: (previousSchool) =>
                    _student.previousSchool = previousSchool,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Observação',
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
