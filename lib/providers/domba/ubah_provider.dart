import 'package:first/services/domba/update_service.dart';
import 'package:flutter/material.dart';

class UpdateDombaProvider with ChangeNotifier {
  final UpdateDombaService _updateDombaService = UpdateDombaService();

  Future<void> updateBobotDomba({
    required String userId,
    required String docId,
    required String bobotBaru,
    required BuildContext context,
  }) async {
    try {
      await _updateDombaService.updateBobotDomba(
        userId: userId,
        docId: docId,
        bobotBaru: bobotBaru,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data domba berhasil diubah')),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error update data domba: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengubah data domba: $e')),
      );
    }
  }
}
