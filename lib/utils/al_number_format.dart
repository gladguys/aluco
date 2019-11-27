import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class ALNumberFormat {
  static String formatMonetary({
    String number,
    String symbol = 'R\$',
    int decimalDigits = 2,
  }) {
    final NumberFormat numberFormat = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return numberFormat.format(double.parse(convertToDefaultDecimal(number)));
  }

  static String formatDouble({String number}) {
    return NumberFormat.decimalPattern('pt_BR')
        .format(double.parse(convertToDefaultDecimal(number)));
  }

  static String formatDoubleWithDecimal({
    String number,
    int decimalDigits = 2,
  }) {
    final MoneyMaskedTextController controller = MoneyMaskedTextController(
      precision: decimalDigits,
      initialValue: double.parse(convertToDefaultDecimal(number)),
    );

    return controller.text;
  }

  static String convertToDefaultDecimal(String number) {
    return number?.replaceAll(',', '.') ?? '';
  }
}
