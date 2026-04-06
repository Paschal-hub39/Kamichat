import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // 🔐 Auth
  Future<User?> login(String email, String password) async {
    var result = await auth.signInWithEmailAndPassword(email: email, password: password);
    await setOnline(true);
    return result.user;
  }

  Future<User?> signup(String email, String password) async {
    var result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    await firestore.collection('users').doc(result.user!.uid).set({
      'email': email,
      'online': true,
      'profilePic': '',
      'lastSeen': FieldValue.serverTimestamp(),
      'typing': false,
    });
    return result.user;
  }

  void logout() async {
    await setOnline(false);
    await auth.signOut();
  }

  // 💬 Chat
  Future<void> sendMessage(String text) async {
    var user = auth.currentUser;
    if (user == null) return;

    await firestore.collection('messages').add({
      'text': text,
      'senderId': user.uid,
      'time': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getMessages() {
    return firestore.collection('messages').orderBy('time').snapshots();
  }

  // 🟢 Online status
  Future<void> setOnline(bool status) async {
    var user = auth.currentUser;
    if (user != null) {
      await firestore.collection('users').doc(user.uid).update({
        'online': status,
        'lastSeen': FieldValue.serverTimestamp(),
      });
    }
  }

  // 👤 Profile
  Future<void> updateProfilePic(String url) async {
    var user = auth.currentUser;
    if (user != null) {
      await firestore.collection('users').doc(user.uid).update({
        'profilePic': url,
      });
    }
  }

  Stream<DocumentSnapshot> getUserData(String uid) {
    return firestore.collection('users').doc(uid).snapshots();
  }

  // ✍ Typing
  Future<void> setTyping(bool typing) async {
    var user = auth.currentUser;
    if (user != null) {
      await firestore.collection('users').doc(user.uid).update({'typing': typing});
    }
  }
}
