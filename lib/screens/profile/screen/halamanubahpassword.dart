import 'package:first/screens/navigasi/navigasi.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          

          Positioned(
            top: 150,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 158, 158, 158)
                              .withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: oldPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password lama',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        isDense: true,
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 158, 158, 158)
                              .withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: newPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password Baru',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        isDense: true,
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 158, 158, 158)
                              .withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Konfirmasi Password Baru',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        isDense: true,
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  
                  ElevatedButton(
                    onPressed: () async {
                      
                      String oldPassword = oldPasswordController.text;
                      String newPassword = newPasswordController.text;
                      String confirmPassword = confirmPasswordController.text;

                      
                      if (newPassword != confirmPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('Konfirmasi Password Baru tidak sesuai.'),
                          backgroundColor: Colors.red,
                        ));
                        return;
                      }

                      
                      try {
                        User? user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          
                          AuthCredential credential =
                              EmailAuthProvider.credential(
                            email: user.email!,
                            password: oldPassword,
                          );

                          
                          await user.reauthenticateWithCredential(credential);

                          
                          await user.updatePassword(newPassword);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Password berhasil diubah.'),
                            backgroundColor: Colors.green,
                          ));
                        }
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Gagal mengubah password: $error'),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(380, 60)),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.all(12)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(104, 119, 68, 1)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Text(
                      'Ganti Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: navigasi(),
    );
  }
}
