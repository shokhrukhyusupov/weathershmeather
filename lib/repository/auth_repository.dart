import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _storage = const FlutterSecureStorage();

  Future<UserCredential> emailSignIn(String email, String password) async {
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      _storage.write(key: 'email', value: email);
      _storage.write(key: 'password', value: password);
      return user;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  Future<UserCredential> emailSignUp(String email, String password) async {
    try {
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      _storage.write(key: 'email', value: email);
      _storage.write(key: 'password', value: password);
      return user;
    } on FirebaseException catch (e) {
      final asd = await isExist(_firebaseAuth.currentUser!.uid);
      if (e.code == 'email-already-in-use' && !asd) {
        final user = await emailSignIn(email, password);
        return user;
      } else {
        throw e.message.toString();
      }
    }
  }

  Future<bool> isExist(String uid) async {
    final querySnapshot = _collectionReference.doc(uid);
    final data = await querySnapshot.get();
    return data.exists;
  }

  Future<GoogleSignInAccount> googleSignIn() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        await _firebaseAuth.signInWithCredential(credential);
        final uid = _firebaseAuth.currentUser!.uid;
        await _collectionReference.doc(uid).set({
          'uid': uid,
          'email': googleUser.email,
          'displayName': googleUser.displayName,
          'photoUrl': googleUser.photoUrl,
        });
        _storage.write(key: 'token', value: uid);
      }
      return googleUser!;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  Future<User> signInWithToken() async {
    final email = await _storage.read(key: 'email') as String;
    final password = await _storage.read(key: 'password') as String;
    final user = await emailSignIn(email, password);
    return user.user!;
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<void> signOutfromEmail() async {
    _storage.delete(key: 'token');
    await _firebaseAuth.signOut();
  }

  Future<void> signOutFromGoogle() async {
    _storage.delete(key: 'token');
    await _googleSignIn.signOut();
  }
}
