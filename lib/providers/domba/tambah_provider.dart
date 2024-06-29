import 'package:first/services/domba/tambah_service.dart';
import 'package:flutter/material.dart';

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
}
