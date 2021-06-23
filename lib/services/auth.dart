import "package:firebase_auth/firebase_auth.dart";

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signUp(String email, String password) async {
    final UserCredential authResutl = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return authResutl;
  }

  Future<UserCredential> signIn(String email, String password) async {
    final authResutl = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return authResutl;
  }
  Future<void> signOut()async{
   await _auth.signOut();
  }
}
