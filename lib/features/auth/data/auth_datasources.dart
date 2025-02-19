// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_auracode_app/core/data/chat_datasource.dart';
import 'package:my_auracode_app/core/error/server_failure.dart';
import 'package:my_auracode_app/core/model/user.dart' as userModel;

class AuthDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final ChatDataSource chatDatasource;

  AuthDataSource({required this.chatDatasource});

  Future<userModel.User> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw ServerException("User not found!");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw ServerException("Something went wrong!");
      }
      final user =
          await chatDatasource.saveUserToFirestore(userCredential.user!);

      return user;
    } catch (e) {
      throw ServerException('Error during Google Sign-In: $e');
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
