import 'package:bcrypt/bcrypt.dart';

/// Assuming we can securely *transport* the authentication credentials (email & password) to the backend, are we
/// storing them securely? Let's convert it from plaintext to something obscured.
main() {
  //region Frontend
  var myEmail = 'foo@bar.baz';
  var myPassword = 'nevergonnaguessit';
  //endregion Frontend

  //region Backend
  /// Let's modify the password so that we're not storing the plaintext. How should we obscure it?
  /// HASHING! Let's use bcrypt

  final String hashedPassword = BCrypt.hashpw(myPassword, BCrypt.gensalt());

  var myAuthData = {
    'email': myEmail,
    'password': hashedPassword,
  };

  print(myAuthData); // => {email: foo@bar.baz, password: $2a$10$42vyDSVn8tgbrjkbVn8yH.UQsnCBu17gcH4wwDe5oo.VD/TJlkWWa}
  //endregion Backend

  //region Hacker
  final bool checkPassword = BCrypt.checkpw('isthisyourpassword?', hashedPassword);
  print(checkPassword); // => false
  //endregion Hacker
}
