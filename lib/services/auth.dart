import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthService {
  final FirebaseAuth _auth;
  AuthService(this._auth);

  Stream<User?> get authState => _auth.authStateChanges();

  Future<User?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = 
      await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken
    );

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User? user = authResult.user;


  assert(await user!.getIdToken() != null);

  final User? currentUser = await _auth.currentUser;
  assert(currentUser!.uid == user?.uid);
  
  return user;

  }

  Future<User?> signUpwithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> signInwithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

}