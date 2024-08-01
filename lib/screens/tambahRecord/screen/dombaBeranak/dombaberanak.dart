import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/screens/navigasi/navigasi.dart';
import 'package:flutter/material.dart';

class DombaChild extends StatefulWidget {
  @override
  _DombaChildState createState() => _DombaChildState();
}

class _DombaChildState extends State<DombaChild> {
  String? selectedKodeDomba;
  TextEditingController _urutanController = TextEditingController();
  DateTime? _selectedDate;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Stack(
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
                  Center(
                    child: Text(
                      'Domba Beranak',
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
                      color: Color.fromRGBO(
                          104, 119, 69, 1)), 
                  color: Colors.white, 
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10), 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Kode Domba Domba Betina',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(117, 117, 117, 1)),
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
                        color: Colors.white, 
                      ),
                      child: Center(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('domba')
                              .doc(user!.uid)
                              .collection('dataDomba')
                              .where('jenisKelamin',
                                  isNotEqualTo: 'SQ7e1oe2XtoQCQRYOQXe')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            }

                            var dropdownItems = snapshot.data!.docs
                                .map((doc) => DropdownMenuItem<String>(
                                      value: doc['kodeDomba'],
                                      child: Text('   ${doc['kodeDomba']}'),
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
                          bottom: 10), 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Urutan Beranak Ke-Berapa',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(117, 117, 117, 1)),
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
                        color: Colors.white, 
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: _urutanController,
                              decoration: InputDecoration(
                                  hintText: 'Masukkan urutan',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  isDense: true,
                                  alignLabelWithHint: true,
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromRGBO(117, 117, 117, 100))),
                              textAlign: TextAlign
                                  .left, 
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10), 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Tanggal Beranak',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(117, 117, 117, 1)),
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
                        color: Colors.white, 
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

            
            Positioned(
              top: 500,
              left: 40,
              right: 40,
              child: ElevatedButton(
                onPressed: () {
                  _saveDataToFirestore();
                },
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all<Size>(
                      Size(180, 60)), 
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(12)), 
                  backgroundColor: WidgetStateProperty.all<Color>(
                      Color.fromRGBO(104, 119, 68, 1)),
                  shape: WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), 
                    ),
                  ),
                ),
                child: Text(
                  'Ubah Data Domba',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18 
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

  String _tanggalText() {
    if (_selectedDate != null) {
      return '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
    } else {
      return 'Pilih Tanggal';
    }
  }

  void _saveDataToFirestore() {
    String? kodeDomba = selectedKodeDomba;
    String urutanBeranak = _urutanController.text.trim();
    DateTime? tanggalBeranak = _selectedDate;

    if (kodeDomba == null) {
      _showSnackbar('Kode domba harus dipilih');
      return;
    }

    if (urutanBeranak.isEmpty) {
      _showSnackbar('Urutan beranak harus diisi');
      return;
    }

    if (int.tryParse(urutanBeranak) == null) {
      _showSnackbar('Urutan beranak harus berupa angka');
      return;
    }

    if (tanggalBeranak == null) {
      _showSnackbar('Tanggal beranak harus dipilih');
      return;
    }

    Map<String, dynamic> dataBeranak = {
      'kodeDomba': kodeDomba,
      'urutanBeranak': urutanBeranak,
      'tanggalBeranak': tanggalBeranak,
    };

    FirebaseFirestore.instance
        .collection('record_beranak')
        .doc(user!.uid)
        .collection('dataBeranak')
        .add(dataBeranak)
        .then((value) {
      print('Data berhasil disimpan ke Firestore');
      Navigator.pop(context);
    }).catchError((error) {
      print('Error: $error');
      _showSnackbar('Terjadi kesalahan saat menyimpan data');
    });
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
