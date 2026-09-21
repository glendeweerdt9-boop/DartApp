import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> _userDoc(String uid) =>
      _db.collection('users').doc(uid);

  Future<void> ensureUserProfile(User user) async {
    final ref = _userDoc(user.uid);
    final snapshot = await ref.get();
    final data = <String, dynamic>{
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'photoUrl': user.photoURL,
      'updatedAt': FieldValue.serverTimestamp(),
    };
    if (!snapshot.exists) {
      data['createdAt'] = FieldValue.serverTimestamp();
    }
    await ref.set(data, SetOptions(merge: true));
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> profile(String uid) =>
      _userDoc(uid).snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> matches(String uid) =>
      _userDoc(uid).collection('matches')
          .orderBy('createdAt', descending: true)
          .limit(100)
          .snapshots();

  Future<void> saveMatch({
    required User user,
    required String game,
    required List<String> players,
    required int winnerIndex,
    required List<int> scores,
  }) async {
    await ensureUserProfile(user);
    await _userDoc(user.uid).collection('matches').add({
      'game': game,
      'players': players,
      'winnerIndex': winnerIndex,
      'scores': scores,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
