import 'package:first/services/record/kawin_service.dart';
import 'package:flutter/material.dart';

class DombaKawinProvider with ChangeNotifier {
  final DombaKawinService _dombaKawinService = DombaKawinService();

  Future<void> simpanDataKawin({
    required String userId,
    required String kodeDomba,
    required DateTime tanggalKawin,
    required BuildContext context,
  }) async {
    try {
      await _dombaKawinService.simpanDataKawin(
        userId: userId,
        kodeDomba: kodeDomba,
        tanggalKawin: tanggalKawin,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data kawin berhasil ditambahkan')),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error simpan data kawin: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menambah data kawin: $e'),
        ),
      );
    }
  }
}
