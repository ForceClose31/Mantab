import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void updateSheepAge() async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final firestore = FirebaseFirestore.instance;

  final querySnapshot = await firestore
      .collection('domba')
      .where('uid', isEqualTo: uid)
      .get();

  for (var doc in querySnapshot.docs) {
    final data = doc.data();
    final umurSekarang = int.parse(data['umurDomba'].toString());
    final tanggalInput = (data['tanggalInput'] as Timestamp).toDate();

    final bulanSekarang = DateTime.now().month;
    final bulanInput = tanggalInput.month;
    final umurBaru = umurSekarang + (bulanSekarang - bulanInput);

    await doc.reference.update({
      'umurDomba': umurBaru,
      'tanggalInput': DateTime.now(),
    });
  }
}
