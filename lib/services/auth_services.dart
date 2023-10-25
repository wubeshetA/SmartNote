import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartnote/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Convert Firebase User to UserModel
  UserModel? _fromFirebaseUser(User? user) {
    if (user == null) return null;

    return UserModel(
      uid: user.uid,
      email: user.email,
      // displayName: user.displayName,
      // photoURL: user.photoURL,
    );
  }

  // Stream to listen to user authentication changes
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_fromFirebaseUser);
  }

  // Sign up with email and password
  Future<UserModel?> signUp(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        await user.updateDisplayName(name);
      }
      return _fromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Sign in with email and password
  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _fromFirebaseUser(user);
    } catch (error) {
      print("-------error while sign in with email and password-----------");
      print(error.toString());
      return null;
    }
  }

  // Sign out
 Future<void> signOut() async {
  final User? currentUser = _auth.currentUser;

  if (currentUser != null) {
    for (UserInfo info in currentUser.providerData) {
      if (info.providerId == 'google.com') { // Google Sign-in
        await GoogleSignIn().signOut();
      }
    }
  }

  await _auth.signOut();
}


  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        final User? user = authResult.user;

        return _fromFirebaseUser(user);
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  // Future<void> signOutWithGoogle() async {
  //   await GoogleSignIn().signOut();
  // }
}
