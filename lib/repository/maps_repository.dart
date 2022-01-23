import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weathershmeather/models/place.dart';

class MapsRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> savePlace({required Place place}) async {
    final uid = _auth.currentUser!.uid;
    await _collectionReference.doc(uid).collection('address').add({
      'formattedAddress': place.formattedAddress,
      'lat': place.lat,
      'lng': place.lng,
    });
  }
}
