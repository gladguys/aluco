import 'package:flutter/material.dart';

class FormUtils {
  static isValid(FormState form) {
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

const FormVerticalSeparator = const SizedBox(height: 18);