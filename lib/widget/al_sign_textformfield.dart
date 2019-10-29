import 'package:flutter/material.dart';

class ALSignTextFormField extends StatelessWidget {
  const ALSignTextFormField({
    this.labelText,
    this.prefixIconData,
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.validator,
    this.focusNode,
    this.onFieldSubmitted,
    this.onSaved,
  });

  final String labelText;
  final IconData prefixIconData;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final bool obscureText;
  final Function validator;
  final FocusNode focusNode;
  final Function onFieldSubmitted;
  final Function onSaved;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(12.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: prefixIconData != null
                ? Icon(
                    prefixIconData,
                    color: Theme.of(context).primaryColorDark,
                    size: 24.0,
                  )
                : null,
            isDense: true,
            fillColor: Colors.white,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
          textInputAction: textInputAction,
          obscureText: obscureText,
          validator: validator,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
        ),
      ),
    );
  }
}
