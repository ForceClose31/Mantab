import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:first/providers/login/login_provider.dart';
import 'package:first/screens/login/views/login.dart';
import 'package:first/screens/navigasi/navigasi.dart';
import 'package:first/screens/profile/screen/halamanubahpassword.dart';

class HalamanProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/images/bgbatik.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: constraints.maxHeight * 0.4,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Halaman Profil',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(49, 52, 19, 1),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Image.asset(
                          'lib/images/PP.png',
                          width: 100,
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Nama',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(117, 117, 117, 1),
                              ),
                            ),
                          ),
                          StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(user!.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              }
                              var userData = snapshot.data!.data() as Map<String, dynamic>?;

                              if (userData != null) {
                                return Container(
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
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                    child: Text(
                                      userData['nama'],
                                      style: TextStyle(
                                        color: Color.fromRGBO(117, 117, 117, 1),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Text('Data tidak tersedia');
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Nomor Anggota Kelompok',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(117, 117, 117, 1),
                              ),
                            ),
                          ),
                          StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              }
                              var userData = snapshot.data!.data() as Map<String, dynamic>?;

                              if (userData != null) {
                                return Container(
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
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                    child: Text(
                                      userData['nomorAnggota'].toString(),
                                      style: TextStyle(
                                        color: Color.fromRGBO(117, 117, 117, 1),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Text('Data tidak tersedia');
                              }
                            },
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ChangePassword()),
                              );
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(Size(180, 60)),
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(12)),
                              backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(0, 163, 255, 1)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Ubah Kata Sandi',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 20),
                          OutlinedButton(
                            onPressed: () async {
                              await loginProvider.logout();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(Size(180, 60)),
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(12)),
                              backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(255, 0, 0, 1)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Keluar',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: navigasi(),
    );
  }
}
