import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int expirationTime = DateTime.now().add(Duration(hours: 2)).millisecondsSinceEpoch;
      await prefs.setInt('token_expiration', expirationTime);
      
      return userCredential.user;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
