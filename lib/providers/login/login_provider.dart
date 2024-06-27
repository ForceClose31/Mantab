import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/services/login/login_service.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  final LoginService _loginService = LoginService();

  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    try {
      User? user = await _loginService.loginUser(email, password);
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal masuk. Silakan coba lagi.')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Masukkan data dengan benar.')),
      );
    }
  }
}
