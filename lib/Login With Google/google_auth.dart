import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  // Liste  e-mails autorisés
  final List<String> allowedDomains = ["example.com"];
  final List<String> allowedEmails = ["admin@example.com"];

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await auth.signInWithCredential(authCredential);
        final User? user = userCredential.user;

        if (user != null) {
          final String? email = user.email;

          if (_isEmailAllowed(email)) {
            print("Connexion autorisée pour $email");
          } else {
            print("Connexion refusée pour $email");
            await googleSignOut();
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      print("Erreur lors de la connexion : ${e.message}");
    }
  }

  bool _isEmailAllowed(String? email) {
    if (email == null) return false;

    for (var domain in allowedDomains) {
      if (email.endsWith("@$domain")) {
        return true;
      }
    }

    if (allowedEmails.contains(email)) {
      return true;
    }

    return false;
  }

  googleSignOut() async {
    await googleSignIn.signOut();
    auth.signOut();
  }
}
