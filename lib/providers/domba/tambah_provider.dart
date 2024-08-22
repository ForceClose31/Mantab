import 'package:first/services/domba/tambah_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DombaProvider with ChangeNotifier {
  final DombaService _dombaService = DombaService();

  Future<void> tambahDataDomba({
    required String uid,
    required String kodeDomba,
    required String bobotDomba,
    required String umurDomba,
    required String jenisKelamin,
    required BuildContext context,
  }) async {
    try {
      await _dombaService.tambahDataDomba(
        uid: uid,
        kodeDomba: kodeDomba,
        bobotDomba: bobotDomba,
        umurDomba: umurDomba,
        jenisKelamin: jenisKelamin,
      );
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data domba berhasil ditambahkan')),
      );
    } catch (e) {
      print('Error tambah data domba: $e');
      String errorMessage;

      if (e.toString().contains('Kode Domba hanya boleh angka')) {
        errorMessage = 'Kode Domba hanya boleh angka';
      } else if (e.toString().contains('Bobot Domba hanya boleh angka')) {
        errorMessage = 'Bobot Domba hanya boleh angka';
      } else if (e.toString().contains('Umur Domba hanya boleh angka')) {
        errorMessage = 'Umur Domba hanya boleh angka';
      } else {
        errorMessage = 'Gagal menambah data domba: $e';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  Future<void> updateSheepAge() async {
    try {
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
      print("Umur domba berhasil diperbarui.");
    } catch (e) {
      print("Gagal memperbarui umur domba: $e");
    }
  }
}
