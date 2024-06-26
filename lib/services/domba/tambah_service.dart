import 'package:cloud_firestore/cloud_firestore.dart';

class DombaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> tambahDataDomba({
    required String uid,
    required String kodeDomba,
    required String bobotDomba,
    required String umurDomba,
    required String jenisKelamin,
  }) async {
    try {
      await _firestore
          .collection('domba')
          .doc(uid)
          .collection('dataDomba')
          .add({
        'kodeDomba': kodeDomba,
        'bobotDomba': bobotDomba,
        'umurDomba': umurDomba,
        'jenisKelamin': jenisKelamin,
      });
    } catch (e) {
      print('Error tambah data domba: $e');
      throw e;
    }
  }
}
