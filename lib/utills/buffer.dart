// Buffer

// class NumberTextInputFormatter extends TextInputFormatter {
//   @override
//    TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     final int newTextLength = newValue.text.length;
//     int selectionIndex = newValue.selection.end;
//     int usedSubstringIndex = 0;
//     final StringBuffer newText = new StringBuffer();
//     if (newTextLength >= 1) {
//       newText.write('+');
//       if (newValue.selection.end >= 1) selectionIndex++;
//     }
//     if (newTextLength >= usedSubstringIndex)
//       newText.write(newValue.text.substring(usedSubstringIndex));
//     return new TextEditingValue(
//       text: newText.toString(),
//       selection: new TextSelection.collapsed(offset: selectionIndex),
//     );
//   }
// }


// final _mobileFormatter = NumberTextInputFormatter();

// inputFormatters: <TextInputFormatter>[
//   FilteringTextInputFormatter.allow(RegExp("[0-9]")),
//   _mobileFormatter,
// ],

// keyboardType: TextInputType.phone,

// validator: (value) {
//   if (value!.isEmpty) {
//     return 'Номер телефона';
//   } else if (!value.contains('+')) {
//     return 'Введите корректный номер телефона';
//   }
//   return null;
// },