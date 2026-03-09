import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final CollectionReference notes = FirebaseFirestore.instance.collection("notes");

  Future<void> add(String note) async {
    notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> get() {
    return notes.orderBy('timestamp', descending: true).snapshots();
  }
}