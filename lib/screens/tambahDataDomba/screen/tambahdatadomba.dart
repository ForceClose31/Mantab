import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/providers/domba/tambah_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateData extends StatefulWidget {
  @override
  _CreateDataState createState() => _CreateDataState();
}

class _CreateDataState extends State<CreateData> {
  String? jenisKelamin;
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController bobotController = TextEditingController();
  final TextEditingController umurController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      'Tambah Data Domba',
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Kode Domba',
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
                        child: TextField(
                          controller: kodeController,
                          decoration: InputDecoration(
                            hintText: 'Kode',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            isDense: true,
                            alignLabelWithHint: true,
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(117, 117, 117, 100),
                            ),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Bobot Domba (Kg)',
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
                        child: TextField(
                          controller: bobotController,
                          decoration: InputDecoration(
                            hintText: 'Bobot',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            isDense: true,
                            alignLabelWithHint: true,
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(117, 117, 117, 100),
                            ),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Umur Domba (Bulan)',
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
                        child: TextField(
                          controller: umurController,
                          decoration: InputDecoration(
                            hintText: 'Umur',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            isDense: true,
                            alignLabelWithHint: true,
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(117, 117, 117, 100),
                            ),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Jenis Kelamin Domba',
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
                        child: DropdownButton<String>(
                          value: jenisKelamin,
                          hint: Text('Pilih Jenis Kelamin'),
                          onChanged: (String? newValue) {
                            setState(() {
                              jenisKelamin = newValue;
                            });
                          },
                          items:
                              <String>['Jantan', 'Betina'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 600,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  tambahData();
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(180, 60)),
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
                  'Tambah Data Domba',
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
    );
  }

  void tambahData() {
    final dombaProvider = Provider.of<DombaProvider>(context, listen: false);
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final kodeDomba = kodeController.text.trim();
    final bobotDomba = bobotController.text.trim();
    final umurDomba = umurController.text.trim();
    final jenisKelaminId = jenisKelamin == 'Jantan'
        ? 'SQ7e1oe2XtoQCQRYOQXe'
        : 'MJdiCLP726Un0p4A8vu2';

    dombaProvider.tambahDataDomba(
      uid: uid,
      kodeDomba: kodeDomba,
      bobotDomba: bobotDomba,
      umurDomba: umurDomba,
      jenisKelamin: jenisKelaminId,
      context: context,
    );
  }
}
