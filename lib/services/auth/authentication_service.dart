import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ignore: body_might_complete_normally_nullable
  Future<User?> registerUser(
      String email, String password, String nama, String nomorAnggota) async {
    if (!isValidEmail(email)) {
      throw Exception('Email tidak valid');
    }

    if (!isValidPassword(password)) {
      throw Exception(
          'Password harus minimal 8 karakter, terdiri dari huruf, angka, dan simbol');
    }

    if (!isValidNomorAnggota(nomorAnggota)) {
      throw Exception('Nomor Anggota hanya boleh angka');
    }

    if (!isValidNama(nama)) {
      throw Exception('Nama hanya boleh terdiri dari huruf');
    }

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
      print('Masukkan data dengan benar: $e'); // Modifikasi pesan log
      rethrow;
    }
  }

  bool isValidEmail(String email) {
    String emailPattern = r'^[^@]+@[^@]+\.[^@]+';
    return RegExp(emailPattern).hasMatch(email);
  }

  bool isValidPassword(String password) {
    String passwordPattern =
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+|~=`{}\[\]:";\/<>?,./]).{8,}$';
    return RegExp(passwordPattern).hasMatch(password);
  }

  bool isValidNomorAnggota(String nomorAnggota) {
    String nomorPattern = r'^[0-9]+$';
    return RegExp(nomorPattern).hasMatch(nomorAnggota);
  }

  bool isValidNama(String nama) {
    String namaPattern = r'^[a-zA-Z]+$';
    return RegExp(namaPattern).hasMatch(nama);
  }
}
