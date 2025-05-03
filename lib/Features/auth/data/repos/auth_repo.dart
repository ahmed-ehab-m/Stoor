abstract class AuthRepo {
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<String?> getUserId();
}
