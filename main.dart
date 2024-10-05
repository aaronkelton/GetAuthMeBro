/// Assuming we can securely *transport* the authentication credentials (email & password) to the backend, are we
/// storing them securely? No: we're putting them directly into `myAuthData` as plaintext, i.e. no modifications.
///
/// But if our backend is secure, what's the risk? Assuming nobody ever gains access to our database or server, there is
/// still risk that our engineers will be able to see or inspect the plaintext, and could therefore login as this user.
///
/// Therefore, we need to prevent our trusted engineers and also hackers from seeing or inspecting the plaintext
/// password.
main() {
  //region Frontend
  var myEmail = 'foo@bar.baz';
  var myPassword = 'nevergonnaguessit';
  //endregion Frontend

  //region Backend
  var myAuthData = {
    'email': myEmail,
    'password': myPassword,
  };

  print(myAuthData); // => {email: foo@bar.baz, password: nevergonnaguessit}
  //endregion Backend
}
