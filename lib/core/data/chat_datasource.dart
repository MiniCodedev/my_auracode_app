import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_auracode_app/core/model/user.dart' as userModel;

class ChatDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<userModel.User> saveUserToFirestore(User user) async {
    final userData = await getUserData(user.uid);
    if (userData != null) {
      return userData;
    } else {
      final userDoc = _firestore.collection('Users').doc(user.uid);
      await userDoc.set(
        {
          'name': user.displayName,
          'email': user.email,
          'phoneNumber': user.phoneNumber,
          'uid': user.uid,
          'groupList': [],
        },
      );
      return userModel.User(
        uid: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        phoneNumber: user.phoneNumber ?? '',
        groupList: [],
      );
    }
  }

  Future<userModel.User?> getUserData(String uid) async {
    final userData =
        (await _firestore.collection("Users").doc(uid).get()).data();
    if (userData == null) {
      return null;
    }
    return userModel.User.fromMap(userData);
  }

  Future<void> sendMessage(
      String chatId, String senderId, String message) async {
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'senderId': senderId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
