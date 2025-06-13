class PasswordValidator {
  static String? validate(
    String? password, {
    String? emptyMessage,
    String? lengthMessage,
    String? uppercaseMessage,
    String? numberMessage,
    String? specialCharMessage,
  }) {
    emptyMessage ??= 'Password cannot be empty';
    lengthMessage ??= 'Password must be at least 8 characters long';
    uppercaseMessage ??= 'Password must contain at least one uppercase letter';
    numberMessage ??= 'Password must contain at least one number';
    specialCharMessage ??= 'Password must contain at least one special character';

    if (password == null || password.isEmpty) {
      return emptyMessage;
    }

    if (password.length < 8) {
      return lengthMessage;
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      return uppercaseMessage;
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      return numberMessage;
    }

    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return specialCharMessage;
    }

    return null;
  }
}