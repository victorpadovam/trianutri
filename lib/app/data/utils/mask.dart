import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';

class Mask {
  static final NumberTextInputFormatter floatMask = NumberTextInputFormatter(
    integerDigits: 3,
    decimalDigits: 2,
    maxValue: '999.99',
    decimalSeparator: '.',
    groupDigits: 3,
    groupSeparator: ',',
    allowNegative: false,
    overrideDecimalPoint: true,
    insertDecimalPoint: true,
    insertDecimalDigits: false,
  );

  static final MaskTextInputFormatter dateMask = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
}
