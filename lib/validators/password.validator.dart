import 'package:formz/formz.dart';

enum PasswordError {
  empty,
  invalid
}

class PasswordValidator extends FormzInput<String, PasswordError> {
  const PasswordValidator.pure([super.value = '']) : super.pure();
  const PasswordValidator.dirty([super.value = '']) : super.dirty();

  static final RegExp _passwordRegExp = RegExp(
    r'^[0-9]\d{5}$',
  );

  @override
  PasswordError? validator(String value) {
    if (value.isNotEmpty == false) {
      return PasswordError.empty;
    }
    return _passwordRegExp.hasMatch(value)
        ? null
        : PasswordError.invalid;
  }
}

extension ExplanationPassword on PasswordError {
  String get number {
    switch(this) {
      case PasswordError.invalid:
        return "This is not a valid password";
      default:
        return '';
    }
  }
}