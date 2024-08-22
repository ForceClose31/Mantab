import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/services/login/login_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  final LoginService _loginService = LoginService();

  Future<void> checkLoginStatus(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? expirationTime = prefs.getInt('token_expiration');

    if (expirationTime != null && DateTime.now().millisecondsSinceEpoch < expirationTime) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  Future<void> loginUser(BuildContext context, String email, String password) async {
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

  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token_expiration'); 
      Navigator.pushReplacementNamed(context, '/welcome');
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal logout.')),
      );
    }
  }

}
