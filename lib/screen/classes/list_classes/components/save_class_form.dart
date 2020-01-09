import 'package:aluco/core/utils/form_utils.dart';
import 'package:aluco/model/class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

class SaveClassForm extends StatefulWidget {
  SaveClassForm([this.classe]);

  final Class classe;

  FormState get form => _saveClassState._formKey.currentState;
  Class get classForm => _saveClassState._class;

  final _saveClassState = _SaveClassFormState();

  @override
  _SaveClassFormState createState() => _saveClassState;
}

class _SaveClassFormState extends State<SaveClassForm> with GGValidators {
  final _formKey = GlobalKey<FormState>();
  MaskedTextController minimumAverageController;
  MaskedTextController maxQntAbsenceController;
  Class _class;

  @override
  void initState() {
    super.initState();
    minimumAverageController = MaskedTextController(mask: '0.0');
    maxQntAbsenceController = MaskedTextController(mask: '000');

    if (widget.classe != null) {
      _class = widget.classe;
      minimumAverageController.text = _class.minimumAverage.toString();
      maxQntAbsenceController.text = _class.maxQntAbsence.toString();
    } else {
      _class = Class();
    }
  }

  @override
  void dispose() {
    minimumAverageController.dispose();
    maxQntAbsenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            GGOutlinedTextFormField(
              labelText: 'Nome',
              initialValue: _class.name,
              onSaved: (name) => _class.name = name,
              validator: (name) => emptyValidator(name.trim()),
            ),
            FormVerticalSeparator,
            GGOutlinedTextFormField(
              labelText: 'Descrição',
              initialValue: _class.description,
              onSaved: (description) => _class.description = description,
            ),
            FormVerticalSeparator,
            Row(
              children: <Widget>[
                Expanded(
                  key: UniqueKey(),
                  flex: 3,
                  child: _buildMinimumAverage(),
                ),
                const Spacer(flex: 1),
                Expanded(
                  key: UniqueKey(),
                  flex: 3,
                  child: _buildMaxQntAbsence(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMinimumAverage() {
    return _class.id != null
        ? Text(
            'Média: ${_class.minimumAverage}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )
        : GGOutlinedTextFormField(
            labelText: 'Média',
            keyboardType: TextInputType.number,
            controller: minimumAverageController,
            onSaved: (minimumAverage) =>
                _class.minimumAverage = double.parse(minimumAverage),
            validator: (minimumAverage) =>
                emptyValidator(minimumAverage.trim()),
          );
  }

  Widget _buildMaxQntAbsence() {
    return _class.id != null
        ? Text(
            'Máximo de Faltas: ${_class.maxQntAbsence}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )
        : GGOutlinedTextFormField(
            labelText: 'Máximo de Faltas',
            keyboardType: TextInputType.number,
            controller: maxQntAbsenceController,
            onSaved: (maxQntAbsence) =>
                _class.maxQntAbsence = int.parse(maxQntAbsence),
            validator: (maxQntAbsence) => emptyValidator(maxQntAbsence.trim()),
          );
  }
}
