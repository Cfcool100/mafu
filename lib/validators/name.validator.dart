import 'package:formz/formz.dart';

enum NameError { empty, invalid }

class Name extends FormzInput<String, NameError> {
  const Name.pure() : super.pure('');
  const Name.dirty([super.value = '']) : super.dirty();

  static final RegExp _nameRegExp = RegExp(
    r"^[a-zA-Z][a-zA-Z\é\è\ê\']*(\s+[A-Z][a-zA-Z\é\è\ê\']*)*$",
  );

  @override
  NameError? validator(String value) {
    if (value.isNotEmpty == false) {
      return NameError.empty;
    }
    return _nameRegExp.hasMatch(value) ? null : NameError.invalid;
  }
}

extension ExplanationName on NameError {
  String get number {
    switch (this) {
      case NameError.invalid:
        return "This is not a valid name";
      default:
        return '';
    }
  }
}
