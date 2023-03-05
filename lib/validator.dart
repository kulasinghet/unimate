class Validator {
  static String? validateName({required String name}) {
    // if (name == null) {
    //   return null;
    // }
    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }
    RegExp exp1 = RegExp(r'^[a-zA-Z]+$');
    if(!exp1.hasMatch(name[0]))
    {
      return 'Name should starts with a Letter';
    }
    RegExp exp2 = RegExp(r'^[\w| ]+$');
    if(!exp2.hasMatch(name))
    {
      return 'Name must have only Alphanumeric characters or spaces';
    }
    return null;
  }

  static String? validateEmail({required String email}) {
    // if (email == null) {
    //   return null;
    // }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z\d.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z\d](?:[a-zA-Z\d-]{0,253}[a-zA-Z\d])?(?:\.[a-zA-Z\d](?:[a-zA-Z\d-]{0,253}[a-zA-Z\d])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a Valid email';
    }

    return null;
  }

  static String? validatePassword({required String password}) {
    // if (password == null) {
    //   return null;
    // }
    RegExp exp1  = RegExp(r'\d');
    RegExp exp2  = RegExp(r'[a-z]');
    RegExp exp3  = RegExp(r'[A-Z]');
    RegExp exp4  = RegExp(r'\W');

    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 8) {
      return 'Enter a password with length at least 8';
    }
    else if(!exp1.hasMatch(password))
    {
      return 'Password should contains at least 1 digit';
    }
    else if(!password.contains(exp2))
      {
        return 'Password should contains at least 1 lowercase letter';
      }
    else if(!password.contains(exp3))
    {
      return 'Password should contains at least 1 uppercase letter';
    }
    else if(!password.contains(exp4))
    {
      return 'Password should contains at least 1 special character';
    }

    //

    return null;
  }
}