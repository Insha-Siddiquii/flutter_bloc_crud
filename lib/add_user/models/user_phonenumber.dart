import 'package:formz/formz.dart';

enum UserphonenumberValidationError { empty, inValid }

class Userphonenumber
    extends FormzInput<String, UserphonenumberValidationError> {
  const Userphonenumber.pure() : super.pure('');
  const Userphonenumber.dirty([String value = '']) : super.dirty(value);

  @override
  UserphonenumberValidationError? validator(String? value) {
    if (value!.isEmpty) {
      return UserphonenumberValidationError.empty;
    } else if (!(value.length == 10)) {
      return UserphonenumberValidationError.inValid;
    }
    return null;
  }
}
