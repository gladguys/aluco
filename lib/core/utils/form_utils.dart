import 'package:flutter/material.dart';

class FormUtils {
  static bool isValid(FormState form) {
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

const FormVerticalSeparator = SizedBox(height: 16.0);
const FormVerticalSeparatorMedium = SizedBox(height: 24.0);