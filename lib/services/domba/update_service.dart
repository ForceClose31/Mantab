import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateDombaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateBobotDomba({
    required String userId,
    required String docId,
    required String bobotBaru,
  }) async {
    try {
      await _firestore
          .collection('domba')
          .doc(userId)
          .collection('dataDomba')
          .doc(docId)
          .update({
        'bobotDomba': bobotBaru,
      });
    } catch (e) {
      print('Error update bobot domba: $e');
      throw e;
    }
  }
}
