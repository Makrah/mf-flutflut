enum AuthState {
  authent,
  unauthent,
  splash,
}

enum LoginState { success, error, noInternet }

enum SignupState {
  success,
  error,
  invalidUsername,
  invalidPassword,
  passwordsDontMatch,
  noInternet
}

enum ProfileState { success, error, noInternet }
