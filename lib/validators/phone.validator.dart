import 'package:formz/formz.dart';

enum PhoneNumberError { empty, invalid }

class PhoneNumber extends FormzInput<String, PhoneNumberError> {
  const PhoneNumber.pure([super.value = '']) : super.pure();
  const PhoneNumber.dirty([super.value = '']) : super.dirty();

  static final RegExp _phoneNumberRegExp = RegExp(
    r'^(?:\+225)?(07|05|01|77|74|66)[0-9]{8}$',
    // r'^(07|05|01)[0-9]{10}|\(77|74|66)[0-9]{7}$'
  );

  @override
  PhoneNumberError? validator(String value) {
    if (value.isNotEmpty == false) {
      return PhoneNumberError.empty;
    }
    return _phoneNumberRegExp.hasMatch(value) ? null : PhoneNumberError.invalid;
  }
}

extension ExplanationNumber on PhoneNumberError {
  String get number {
    switch (this) {
      case PhoneNumberError.invalid:
        return "This is not a valid number. try with code. eg: (+225)";
      default:
        return '';
    }
  }
}
