/// Assuming we can securely *transport* the authentication credentials (email & password) to the backend, are we
/// storing them securely? Let's convert it from plaintext to something obscured.
main() {
  //region Frontend
  var myEmail = 'foo@bar.baz';
  var myPassword = 'nevergonnaguessit';
  //endregion Frontend

  //region Backend
  /// Let's modify the password so that we're not storing the plaintext. How should we obscure it?
  /// Naively, let's increment the string by some value. Our "encryption key" is the value 1
  var passwordCodeUnits = [];
  for (var char in myPassword.split('')) {
    passwordCodeUnits.add(char.codeUnits.first + 1);
  }
  dynamic obscuredPassword = [];
  for (var codepoint in passwordCodeUnits) {
    obscuredPassword.add(String.fromCharCode(codepoint));
  }
  obscuredPassword = obscuredPassword.join('');

  var myAuthData = {
    'email': myEmail,
    'password': obscuredPassword,
  };

  /// Like pig latin, this obscuring algorithm is easy to figure out. The length is the exact same as the real password!
  /// But hey it's better than plaintext, right? Incremental progress 💪
  print(myAuthData); // => {email: foo@bar.baz, password: ofwfshpoobhvfttju}
  //endregion Backend
}
