import 'package:encrypt/encrypt.dart';

/// Assuming we can securely *transport* the authentication credentials (email & password) to the backend, are we
/// storing them securely? Let's convert it from plaintext to something obscured.
main() {
  //region Frontend
  var myEmail = 'foo@bar.baz';
  var myPassword = 'nevergonnaguessit';
  //endregion Frontend

  //region Backend
  /// Let's modify the password so that we're not storing the plaintext. How should we obscure it?
  /// ENCRYPTION! The Salsa20 one from encrypt has the easiest example to follow, so let's use that.

  final key = Key.fromLength(32);
  final iv = IV.fromLength(8); // IV == initialization vector, a.k.a. "nonce"
  final encrypter = Encrypter(Salsa20(key));

  final encrypted = encrypter.encrypt(myPassword, iv: iv);

  var myAuthData = {
    'email': myEmail,
    'password': encrypted.base64,
  };

  /// This encryption is better than the last one because the length isn't the same as the password, AND the outcome
  /// isn't predictable (run it repeatedly and you'll get different encrypted strings)
  /// But if we get different strings, how could someone authenticate? Don't we have to look up their password and
  /// compare what they submitted to what we are storing? YES... we have to store the IV somehow (prepend to PW?)
  print(myAuthData); // => {email: foo@bar.baz, password: 5UvtzqS2O5A57FGfhON0TLk=}
  //endregion Backend

  //region Hacker
  final decrypted = encrypter.decrypt(encrypted, iv: iv);
  print(decrypted); // => nevergonnaguessit
  //endregion Hacker
  /// We just got hacked! Encryption allows for 2-way obscuration. This 2-way feature shouldn't be confused with
  /// symmetric vs asymmetric in encryption vernacular. Hmm, so we need an obscured password that can't be deciphered.
  /// When a user authenticates, we'll compare the obscured input with our stored obscured value. We don't need to get
  /// back to plaintext! This also means a user can't "recover" a missing or forgotten password. We would only allow
  /// them to reset their password. Once forgotten, it is forgotten forever!
  /// ... well almost ... we could store *hashed* passwords and compare their new password(hashed) to these values.
}
