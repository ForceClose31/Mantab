import 'package:flutter/material.dart';
import '../../services/auth/authentication_service.dart';

class AuthenticationProvider with ChangeNotifier {
  final AuthenticationService _authService = AuthenticationService();

  Future<void> registerUser(BuildContext context, String email, String password,
      String nama, int nomorAnggota) async {
    try {
      await _authService.registerUser(email, password, nama, nomorAnggota);
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
