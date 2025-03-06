import 'package:uuid/uuid.dart';

abstract class FormValidators {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6 || password.length > 20) {
      return 'Password must be between 6 and 20 characters';
    }
    return null;
  }

  static String? validateGroupCode(String? groupCode) {
    if (groupCode == null || groupCode.isEmpty) {
      return 'Group code is requried';
    }

    if (!Uuid.isValidUUID(fromString: groupCode)) {
      return 'Invalid group code';
    }
    return null;
  }

  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }
    if (username.contains(' ')) {
      return 'Username cannot contain spaces';
    }
    if (username.length < 3 || username.length > 20) {
      return 'Username must be between 3 and 20 characters';
    }
    return null;
  }

  static String? validateImageUrl(String? imageUrl) {
    if (imageUrl == null) {
      return null;
    }
    if (!imageUrl.startsWith('https')) {
      return 'Invalid image url';
    }
    return null;
  }

  static String? validateLogTitle(String? exerciseLogTitle) {
    if (exerciseLogTitle == null || exerciseLogTitle.isEmpty) {
      return 'Title is required';
    }
    return null;
  }
}
