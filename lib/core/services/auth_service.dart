import 'package:anon/core/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  // Get valid user by listening auth state changes.
  Stream<UserModel> get user {
    var user = _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser != null) {
        return UserModel(id: firebaseUser.uid);
      } else {
        return UserModel.empty;
      }
    });
    return user;
  }

  /// Main Authentication method which creates Anonymous user.
  Future<bool> signIn() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Main logout method.
  // It deletes current anonymous user and log outs.
  Future<void> logOut() async {
    // Delete current anonymous user.
    await FirebaseAuth.instance.currentUser!.delete();

    Future.wait([_firebaseAuth.signOut()]);
  }
}
