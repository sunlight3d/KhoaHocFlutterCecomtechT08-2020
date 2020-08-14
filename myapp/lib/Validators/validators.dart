class Validators {
  static isValidEmail(String email) {
    final regularExpression = RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$');
    return regularExpression.hasMatch(email);
  }
  static isValidPassword(String password) => password.length >= 2;
}