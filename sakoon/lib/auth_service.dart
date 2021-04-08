import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final _auth=FirebaseAuth.instance;
  Stream<FirebaseUser> get currentUser => _auth.onAuthStateChanged;
  Future<UserCredential> singInWithCredential(AuthCredential credential) => _auth.signInWithCredential(credential);
  Future<void> logOut()=> _auth.signOut();
}
