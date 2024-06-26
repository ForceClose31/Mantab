import 'package:first/providers/record/kawin_provider.dart';
import 'package:first/screens/navigasi/navigasi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DombaKawin extends StatefulWidget {
  @override
  _DombaKawinState createState() => _DombaKawinState();
}

class _DombaKawinState extends State<DombaKawin> {
  String? selectedKodeDomba;
  DateTime? _selectedDate;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
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
              top: 20, // Atur posisi teks header di sini
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
                      'Domba Kawin',
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
                  ), // Warna outline hijau
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
                            'Kode Domba Betina',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(117, 117, 117, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                        color: Colors.white, // Warna latar belakang putih
                      ),
                      child: Center(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('domba')
                              .doc(user!.uid)
                              .collection('dataDomba')
                              .where('jenisKelamin',
                                  isEqualTo: 'SQ7e1oe2XtoQCQRYOQXe')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            }

                            var dropdownItems = snapshot.data!.docs
                                .map((doc) => DropdownMenuItem<String>(
                                      value: doc['kodeDomba'],
                                      child: Text(doc['kodeDomba']),
                                    ))
                                .toList();

                            return DropdownButton<String>(
                              value: selectedKodeDomba,
                              hint: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Pilih Kode Domba Betina',
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
                                });
                              },
                              items: dropdownItems,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10), // Tambahkan margin bawah
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Tanggal Kawin',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(117, 117, 117, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 55, // Atur tinggi container
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
                        color: Colors.white, // Warna latar belakang putih
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2025),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                _selectedDate = pickedDate;
                              });
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  _tanggalText(),
                                  style: TextStyle(
                                    color: Color.fromRGBO(117, 117, 117, 1),
                                  ),
                                ),
                              ),
                              Icon(Icons.calendar_today),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),

            // Tombol Simpan
            Positioned(
              top: 400,
              left: 40,
              right: 40,
              child: ElevatedButton(
                onPressed: () {
                  simpanDataKawin(context);
                },
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all<Size>(
                      Size(180, 60)), // Ukuran minimum tombol
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(12)), // Padding tombol
                  backgroundColor: WidgetStateProperty.all<Color>(
                      Color.fromRGBO(104, 119, 68, 1)),
                  shape: WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: Text(
                  'Tambah',
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

  String _tanggalText() {
    if (_selectedDate != null) {
      return '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
    } else {
      return 'Pilih Tanggal';
    }
  }

  void simpanDataKawin(BuildContext context) {
    String? kodeDomba = selectedKodeDomba;
    DateTime? tanggalKawin = _selectedDate;

    if (kodeDomba != null && tanggalKawin != null) {
      Provider.of<DombaKawinProvider>(context, listen: false).simpanDataKawin(
        userId: user!.uid,
        kodeDomba: kodeDomba,
        tanggalKawin: tanggalKawin,
        context: context,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Harap lengkapi data sebelum menyimpan'),
        ),
      );
    }
  }
}
