import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:first/screens/navigasi/navigasi.dart';
import 'package:first/screens/penjadwalan/widget/kalender.dart';

class Penjadwalan extends StatefulWidget {
  @override
  _PenjadwalanState createState() => _PenjadwalanState();
}

class _PenjadwalanState extends State<Penjadwalan> {
  String selectedDay = '';
  String activeDay = ''; // Untuk melacak hari aktif

  void changeSelectedDay(String day) {
    setState(() {
      selectedDay = day;
      activeDay = day; // Set hari yang di klik sebagai aktif
    });
  }

  void getData(String hari) {
    selectedDay = hari;
    FirebaseFirestore.instance
        .collection('penjadwalan')
        .where('hari', isEqualTo: selectedDay)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var jadwalList = querySnapshot.docs[0].reference.collection('jadwal');
        jadwalList.get().then((jadwalSnapshot) {
          var jadwalData = jadwalSnapshot.docs;
          jadwalData.sort((a, b) => a['jam'].compareTo(b['jam']));

          for (var jadwal in jadwalData) {
            var jam = jadwal['jam'];
            var kegiatan = jadwal['kegiatan'];
            print('Jam: $jam, Kegiatan: $kegiatan');
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double minButtonWidth = screenWidth * 0.11;
    double minButtonHeight = screenHeight * 0.11;

    // Define button color
    Color defaultButtonColor = Colors.white;
    Color activeButtonColor = Color.fromRGBO(104, 119, 68, 1); // Hijau armi

    return Scaffold(
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
          kalender(),
          Positioned(
            top: 220,
            left: 10,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDayButton('senin', 'Sen', minButtonWidth,
                        minButtonHeight, defaultButtonColor, activeButtonColor),
                    SizedBox(width: 4),
                    _buildDayButton('selasa', 'Sel', minButtonWidth,
                        minButtonHeight, defaultButtonColor, activeButtonColor),
                    SizedBox(width: 4),
                    _buildDayButton('rabu', 'Rab', minButtonWidth,
                        minButtonHeight, defaultButtonColor, activeButtonColor),
                    SizedBox(width: 4),
                    _buildDayButton('kamis', 'Kam', minButtonWidth,
                        minButtonHeight, defaultButtonColor, activeButtonColor),
                    SizedBox(width: 4),
                    _buildDayButton('jumat', 'Jum', minButtonWidth,
                        minButtonHeight, defaultButtonColor, activeButtonColor),
                    SizedBox(width: 4),
                    _buildDayButton('sabtu', 'Sab', minButtonWidth,
                        minButtonHeight, defaultButtonColor, activeButtonColor),
                    SizedBox(width: 4),
                    _buildDayButton('minggu', 'Min', minButtonWidth,
                        minButtonHeight, defaultButtonColor, activeButtonColor),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            top: 340,
            left: 20,
            right: 20,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              margin: EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Waktu        Kegiatan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 400,
            left: -20,
            right: -20,
            bottom: 50,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  children: [
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('penjadwalan')
                          .where('hari', isEqualTo: selectedDay)
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Text(selectedDay);
                          } else {
                            var jadwalList = snapshot.data!.docs[0].reference
                                .collection('jadwal');
                            return StreamBuilder(
                              stream: jadwalList.orderBy('jam').snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> jadwalSnapshot) {
                                if (jadwalSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else {
                                  var jadwalData = jadwalSnapshot.data!.docs;
                                  return Column(
                                    children: jadwalData.map((jadwal) {
                                      var jam = jadwal['jam'];
                                      var kegiatan = jadwal['kegiatan'];
                                      return _buildItem(
                                          time: jam, result1: kegiatan);
                                    }).toList(),
                                  );
                                }
                              },
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: navigasi(),
    );
  }

  Widget _buildDayButton(String day, String label, double width, double height,
      Color defaultColor, Color activeColor) {
    return ElevatedButton(
      onPressed: () {
        changeSelectedDay(day);
        getData(day);
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Color.fromRGBO(104, 119, 68, 1)),
        ),
        minimumSize: Size(width, height),
        padding: EdgeInsets.symmetric(horizontal: 0),
        textStyle: TextStyle(fontSize: 12),
        backgroundColor: activeDay == day ? activeColor : defaultColor,
      ),
      child: Text(
        label,
        style: TextStyle(
            color: activeDay == day
                ? Colors.white
                : Color.fromRGBO(104, 119, 68, 1)),
      ),
    );
  }

  Widget _buildItem({
    required String result1,
    required String time,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
      margin: EdgeInsets.only(bottom: 15),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '$time',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      '$result1',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
