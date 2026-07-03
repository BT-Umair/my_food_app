import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Google Sign-In Service Class
//Second we Create the instance of firebase authentication & google signin.
// Authentication & google sign in is initialize
// We will Create the initSignin Method it willrequire before the authentication.
// Before you are going to start authentication you need to initialize it. it will be mandatory for android if you continue the
// without initializing the for ios it may work but android we will not work.you need to initialize before authentication.

class GoogleSignInService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static bool isInitialize = false;
  static Future<void> initSignIn() async {
    if (!isInitialize) {
      await _googleSignIn.initialize(serverClientId: '715197497935-0aonqdgdln498813hqfdib4msmed59gf.apps.googleusercontent.com');
    }
    isInitialize = true;
  }

  // Sign in with Google
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      initSignIn();
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      final idToken = googleUser.authentication.idToken;
      final authorizationClient = googleUser.authorizationClient;
      GoogleSignInClientAuthorization? authorization = await authorizationClient.authorizationForScopes(['email', 'profile']);
      final accessToken = authorization?.accessToken;
      if (accessToken == null) {
        final authorization2 = await authorizationClient.authorizationForScopes(['email', 'profile']);
        if (authorization2?.accessToken == null) {
          throw FirebaseAuthException(code: "error", message: "error");
        }
        authorization = authorization2;
      }
      final credential = GoogleAuthProvider.credential(accessToken: accessToken, idToken: idToken);
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        await saveUserData(googleUser);
        final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
        final docSnapshot = await userDoc.get();

        if (!docSnapshot.exists) {
          await userDoc.set({
            'uid': user.uid,
            'name': user.displayName ?? '',
            'email': user.email ?? '',
            'photoURL': user.photoURL ?? '',
            'provider': 'google',
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      }
      return userCredential;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  // Sign out
  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
      throw e;
    }
  }

  // Get current user
  static User? getCurrentUser() {
    return _auth.currentUser;
  }
}

Future<void> saveUserData(GoogleSignInAccount user) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userName', user.displayName ?? "");
  await prefs.setString('userEmail', user.email);
  await prefs.setString('userPhoto', user.photoUrl ?? "");
  await prefs.setBool('isLoggedIn', true);
}
