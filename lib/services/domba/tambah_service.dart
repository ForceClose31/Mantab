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
    if (!isValidNumber(kodeDomba)) {
      throw Exception('Kode Domba hanya boleh angka');
    }

    if (!isValidNumber(bobotDomba)) {
      throw Exception('Bobot Domba hanya boleh angka');
    }

    if (!isValidNumber(umurDomba)) {
      throw Exception('Umur Domba hanya boleh angka');
    }

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

  bool isValidNumber(String value) {
    String pattern = r'^[0-9]+$';
    return RegExp(pattern).hasMatch(value);
  }
}
