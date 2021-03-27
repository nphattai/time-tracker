mixin Validator {
  bool isEmpty(String value) => value.isEmpty;
  final String errorTextEmailEmpty = 'Email can not be empty';
  final String errorTextPasswordEmpty = 'Password can not be empty';
}
