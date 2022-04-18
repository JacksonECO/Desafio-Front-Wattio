import 'package:flutter/services.dart';

class PriceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueLength = newValue.text.length;
    var selectionIndex = newValue.selection.end;

    var subIndex = 0;
    final newText = StringBuffer();

    if (oldValue.text.replaceAll('.', '').replaceAll(',', '') ==
        newValue.text.replaceAll('.', '').replaceAll(',', '')) {
      selectionIndex--;
    }

    if (newValueLength > 8) {
      return oldValue;
    }

    if (newValueLength > 5) {
      newText.write(newValue.text.substring(0, subIndex = newValueLength - 5) + '.');
      if (newValue.selection.end > 5) selectionIndex++;
    }

    if (newValueLength > 2) {
      newText.write(newValue.text.substring(subIndex, newValueLength - 2) +
          ',' +
          newValue.text.substring(newValueLength - 2, newValueLength));
      if (newValue.selection.end > 2) selectionIndex++;
    } else {
      newText.write(newValue.text);
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
