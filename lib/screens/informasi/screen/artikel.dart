import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first/screens/navigasi/navigasi.dart';
import 'package:flutter/material.dart';

class Artikel extends StatelessWidget {
  final String imageUrl;
  final String judulArtikel;

  Artikel({
    required this.imageUrl,
    required this.judulArtikel,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Stack(
          children: [
            
            Positioned(
              top: -30,
              left: 0,
              child: Image.network(
                imageUrl,
                width: 430,
                height: 341.5,
                
              ),
            ),

            Positioned(
              top: 20, 
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'lib/images/back.png', 
                      width:
                          24, 
                      height: 24,
                    ),
                  ),
                  SizedBox(height: 10), 
                ],
              ),
            ),

            Positioned(
              top: 320, 
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    judulArtikel,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 400, 
              left: 20,
              right: 20,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 1, 
                      offset: Offset(0,
                          1), 
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 1, 
                      offset: Offset(0,
                          -1), 
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 1, 
                      offset: Offset(-1,
                          0), 
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 1, 
                      offset: Offset(1,
                          0), 
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('informasi')
                        .where('judul', isEqualTo: judulArtikel)
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('Artikel tidak ditemukan'));
                      } else {
                        var data = snapshot.data!.docs.first.data()
                            as Map<String, dynamic>;
                        var isiArtikel = data['artikel'] as String;
                        return Text(
                          isiArtikel,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: navigasi(),
      ),
    );
  }
}
