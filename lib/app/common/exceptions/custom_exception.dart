class CustomException implements Exception {
  final String message;

  const CustomException(this.message);

  @override
  String toString() => message;
}

class UserProfileNotCreatedException implements Exception {
  final String message;
  UserProfileNotCreatedException(this.message);

  @override
  String toString() => message;
}

class EmailNotVerifiedException implements Exception {
  final String message;
  EmailNotVerifiedException(this.message);

  @override
  String toString() => message;
}

class UserNotFoundException implements Exception {
  final String message;
  UserNotFoundException(this.message);

  @override
  String toString() => message;
}

class DuplicateRegisterParamException implements Exception {
  final String? usernameException;
  final String? emailException;
  final String? phoneException;
  DuplicateRegisterParamException({
    this.usernameException,
    this.emailException,
    this.phoneException,
  });
}

class CreateProfileValidationException implements Exception {
  final List<dynamic>? originCityException;
  final List<dynamic>? originCountryException;

  CreateProfileValidationException({
    this.originCityException,
    this.originCountryException,
  });
}

class NoDataException implements Exception {
  final String message;
  NoDataException(this.message);

  @override
  String toString() => message;
}
