import 'package:first/providers/domba/ubah_provider.dart';
import 'package:first/screens/navigasi/navigasi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateDomba extends StatefulWidget {
  @override
  _UpdateDombaState createState() => _UpdateDombaState();
}

class _UpdateDombaState extends State<UpdateDomba> {
  String? selectedKodeDomba;
  String? bobotSebelumnya;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            // Background Image
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
                      width: 24,
                      height: 24,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Ubah Data Domba',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromRGBO(104, 119, 69, 1),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('domba')
                          .doc(user!.uid)
                          .collection('dataDomba')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }

                        var dropdownItems = snapshot.data!.docs
                            .map((doc) => DropdownMenuItem<String>(
                                  value: doc.id,
                                  child: Text(doc['kodeDomba']),
                                ))
                            .toList();

                        return DropdownButton<String>(
                          value: selectedKodeDomba,
                          hint: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Pilih Kode',
                              style: TextStyle(
                                color: Color.fromRGBO(117, 117, 117, 1),
                              ),
                            ),
                          ),
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 36,
                          isExpanded: true,
                          underline: SizedBox(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedKodeDomba = newValue;
                              _getBobotSebelumnya(newValue);
                            });
                          },
                          items: dropdownItems,
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Bobot Domba Sebelumnya (Kg)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(117, 117, 117, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
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
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              bobotSebelumnya ?? '',
                              style: TextStyle(
                                color: Color.fromRGBO(117, 117, 117, 100),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Bobot Domba Sekarang (Kg)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(117, 117, 117, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
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
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: textEditingController,
                              decoration: InputDecoration(
                                hintText: 'Bobot',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                isDense: true,
                                alignLabelWithHint: true,
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(117, 117, 117, 100),
                                ),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 500,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  _updateDataDomba(context);
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(180, 60)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(12),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(104, 119, 68, 1)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: Text(
                  'Ubah Data Domba',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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

  void _getBobotSebelumnya(String? docId) {
    User? user = FirebaseAuth.instance.currentUser;

    if (docId != null) {
      FirebaseFirestore.instance
          .collection('domba')
          .doc(user!.uid)
          .collection('dataDomba')
          .doc(docId)
          .get()
          .then((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          var bobotDomba = snapshot['bobotDomba'];
          setState(() {
            bobotSebelumnya = bobotDomba.toString();
          });
        } else {
          setState(() {
            bobotSebelumnya = 'Data tidak ditemukan';
          });
        }
      }).catchError((error) {
        setState(() {
          bobotSebelumnya = 'Error: $error';
        });
      });
    }
  }

  void _updateDataDomba(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String bobotDombaSekarang = textEditingController.text;

    if (selectedKodeDomba != null) {
      Provider.of<UpdateDombaProvider>(context, listen: false).updateBobotDomba(
        userId: user!.uid,
        docId: selectedKodeDomba!,
        bobotBaru: bobotDombaSekarang,
        context: context,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pilih kode domba terlebih dahulu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
