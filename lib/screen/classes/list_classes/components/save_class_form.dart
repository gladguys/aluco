import 'package:aluco/core/utils/form_utils.dart';
import 'package:aluco/model/class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gg_flutter_components/validator/gg_validators.dart';

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
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: <Widget>[
            GGOutlinedTextFormField(
              labelText: 'Nome',
              width: 400,
              hintText: 'ex: Colégio São João - 5º ano - Tarde - Português',
              initialValue: _class.name,
              onSaved: (name) => _class.name = name,
              validator: (name) => emptyValidator(name.trim()),
            ),
            GGOutlinedTextFormField(
              labelText: 'Descrição',
              width: 400,
              initialValue: _class.description,
              onSaved: (description) => _class.description = description,
            ),
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

class GGOutlinedTextFormField extends StatelessWidget {
  const GGOutlinedTextFormField(
      {@required this.labelText,
      this.width = 300,
      this.hintText,
      this.initialValue,
      this.onSaved,
      this.validator,
      this.keyboardType,
      this.textInputAction,
      this.focusNode,
      this.onEditingComplete,
      this.controller,
      this.enabled,
      this.minLines,
      this.maxLines})
      : assert(labelText != null && labelText != '');

  final String labelText;
  final double width;
  final String hintText;
  final String initialValue;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final VoidCallback onEditingComplete;
  final bool enabled;
  final int minLines;
  final int maxLines;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextFormField(
        onSaved: onSaved,
        enabled: enabled,
        controller: controller,
        validator: validator,
        onEditingComplete: onEditingComplete,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText ?? '',
          hintMaxLines: 2,
          border: const OutlineInputBorder(),
        ),
        initialValue: initialValue,
        minLines: minLines,
        maxLines: maxLines,
      ),
    );
  }
}
