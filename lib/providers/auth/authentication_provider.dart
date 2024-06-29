import 'package:flutter/material.dart';
import '../../services/auth/authentication_service.dart';

class AuthenticationProvider with ChangeNotifier {
  final AuthenticationService _authService = AuthenticationService();

  Future<void> registerUser(BuildContext context, String email, String password,
      String nama, String nomorAnggota) async {
    try {
      await _authService.registerUser(email, password, nama, nomorAnggota);
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      String errorMessage;

      if (e.toString().contains('Email tidak valid')) {
        errorMessage = 'Email tidak valid';
      } else if (e.toString().contains('Password harus minimal 8 karakter')) {
        errorMessage =
            'Password harus minimal 8 karakter, terdiri dari huruf, angka, dan simbol';
      } else if (e.toString().contains('Nomor Anggota hanya boleh angka')) {
        errorMessage = 'Nomor Anggota hanya boleh angka';
      } else if (e.toString().contains('Nama hanya boleh terdiri dari huruf')) {
        errorMessage = 'Nama hanya boleh terdiri dari huruf';
      } else {
        errorMessage = 'Nomor anggota sudah digunakan, gunakan nomor lainnya.';
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      });
    }
  }
}
