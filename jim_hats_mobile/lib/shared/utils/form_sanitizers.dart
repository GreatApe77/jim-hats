abstract class FormSanitizers {
  static String _trim(String? value) {
    return value?.trim() ?? '';
  }

  static String _removeSpaces(String? value) {
    return value?.replaceAll(' ', '') ?? '';
  }

  static String _toLowerCase(String? value) {
    return value?.toLowerCase() ?? '';
  }
  static String sanitizeUsername(String? value){
    return _removeSpaces(value);
  }
  static String sanitizeEmail(String? email) {
    return _toLowerCase(_removeSpaces(email));
  }
}
