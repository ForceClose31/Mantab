import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/screens/navigasi/navigasi.dart';
import 'package:first/screens/tambahDataDomba/screen/tambahdatadomba.dart';
import 'package:first/screens/editDataDomba/screen/ubahdomba.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateDomba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'lib/images/bgbatik.png',
                width: 430,
                height: 341.5,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 25,
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
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),

            
            Positioned(
              top: 60,
              left: 15,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Data Domba',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => CreateData()),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          minimumSize:
                              WidgetStateProperty.resolveWith((states) {
                            final screenWidth =
                                MediaQuery.of(context).size.width;

                            final buttonWidth = screenWidth * 0.4;

                            return Size(buttonWidth, 55);
                          }),
                          padding: WidgetStateProperty.all(EdgeInsets.all(12)),
                          backgroundColor: WidgetStateProperty.all(
                              Color.fromRGBO(0, 163, 255, 1)),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                          elevation: WidgetStateProperty.all(15),
                          shadowColor: WidgetStateProperty.all(
                              Colors.black.withOpacity(1)),
                        ),
                        child: Text(
                          'Tambah',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateDomba(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          minimumSize:
                              WidgetStateProperty.resolveWith((states) {
                            final screenWidth =
                                MediaQuery.of(context).size.width;

                            final buttonWidth = screenWidth * 0.4;

                            return Size(buttonWidth, 55);
                          }),
                          padding: WidgetStateProperty.all(EdgeInsets.all(12)),
                          backgroundColor: WidgetStateProperty.all(
                              Color.fromRGBO(0, 163, 255, 1)),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                          elevation: WidgetStateProperty.all(15),
                          shadowColor: WidgetStateProperty.all(
                              Colors.black.withOpacity(1)),
                        ),
                        child: Text(
                          'Ubah',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 200,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color.fromRGBO(78, 59, 33, 1)),
                  color: Colors.white,
                ),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('domba')
                      .doc(user!.uid)
                      .collection('dataDomba')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (snapshot.data!.docs.isEmpty) {
                      return Text('No data available');
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Domba saat ini',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(117, 117, 117, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildNumberBox(
                                snapshot.data!.docs
                                    .where((doc) =>
                                        doc['jenisKelamin'] ==
                                        'SQ7e1oe2XtoQCQRYOQXe')
                                    .length
                                    .toString(),
                                'Jantan'),
                            _buildNumberBox(
                                snapshot.data!.docs
                                    .where((doc) =>
                                        doc['jenisKelamin'] ==
                                        'MJdiCLP726Un0p4A8vu2')
                                    .length
                                    .toString(),
                                'Betina'),
                            _buildNumberBox(
                                snapshot.data!.docs
                                    .where((doc) =>
                                        int.parse(doc['umurDomba']) < 13)
                                    .length
                                    .toString(),
                                'Anakan'),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            
            Positioned(
              top: 370,
              left: -15,
              right: -15,
              bottom: 50,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('domba')
                            .doc(user.uid)
                            .collection('dataDomba')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }

                          if (snapshot.data!.docs.isEmpty) {
                            return Text('No data available');
                          }

                          
                          List<DocumentSnapshot> sortedDocs =
                              snapshot.data!.docs;
                          sortedDocs.sort((a, b) =>
                              a['kodeDomba'].compareTo(b['kodeDomba']));

                          return Column(
                            children:
                                sortedDocs.map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data() as Map<String, dynamic>;
                              return Column(
                                children: [
                                  _buildItem(
                                    title:
                                        'Bobot : ${data['bobotDomba']}, Umur : ${data['umurDomba']}, Jenis Kelamin : ${data['jenisKelamin']}',
                                    kodeDomba: data['kodeDomba'],
                                    result1: data[
                                        'bobotDomba'], 
                                    result2:
                                        data['umurDomba'], 
                                    result3: data[
                                        'jenisKelamin'], 
                                  ),
                                  SizedBox(height: 10),
                                ],
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: navigasi(),
    );
  }

  Widget _buildItem({
    required String title,
    required String kodeDomba, 
    required String result1, 
    required String result2, 
    required String result3, 
  }) {
    bool isJantan = result3 == 'SQ7e1oe2XtoQCQRYOQXe';
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 7,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                kodeDomba, 
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Bobot : $result1 kg',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Umur : $result2 bulan',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Jenis Kelamin : ${isJantan ? 'Jantan' : 'Betina'}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberBox(String number, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Color.fromRGBO(31, 98, 54, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 0),
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(117, 117, 117, 1),
          ),
        ),
      ],
    );
  }
}
