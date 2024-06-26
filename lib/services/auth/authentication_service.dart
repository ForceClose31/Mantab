import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ignore: body_might_complete_normally_nullable
  Future<User?> registerUser(
      String email, String password, String nama, int nomorAnggota) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        String userId = userCredential.user!.uid;

        WriteBatch batch = _firestore.batch();

        List<String> tables = [
          'domba',
          'jenis_informasi',
          'jenis_kelamin',
          'record_beranak',
          'record_bunting',
          'record_kawin',
        ];

        tables.forEach((table) {
          batch.set(
            _firestore.collection(table).doc(userId),
            {'userId': userId},
            SetOptions(merge: true),
          );
        });

        batch.set(
          _firestore.collection('users').doc(userId),
          {'userId': userId, 'nama': nama, 'nomorAnggota': nomorAnggota},
          SetOptions(merge: true),
        );

        await batch.commit();

        return userCredential.user;
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
