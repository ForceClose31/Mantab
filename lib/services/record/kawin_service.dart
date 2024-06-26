import 'package:cloud_firestore/cloud_firestore.dart';

class DombaKawinService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> simpanDataKawin({
    required String userId,
    required String kodeDomba,
    required DateTime tanggalKawin,
  }) async {
    try {
      Map<String, dynamic> dataKawin = {
        'kodeDomba': kodeDomba,
        'tanggalKawin': tanggalKawin,
      };

      await _firestore
          .collection('record_kawin')
          .doc(userId)
          .collection('dataKawin')
          .add(dataKawin);
    } catch (e) {
      print('Error simpan data kawin: $e');
      throw e;
    }
  }
}
