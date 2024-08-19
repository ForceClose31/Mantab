import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:first/screens/tambahRecord/screen/dombaBeranak/dombaberanak.dart';
import 'package:first/screens/tambahRecord/screen/dombaBunting/dombabunting.dart';
import 'package:first/screens/tambahRecord/screen/dombaKawin/dombakawinn.dart';

import 'package:first/screens/navigasi/navigasi.dart';

class RecordDomba extends StatefulWidget {
  const RecordDomba({Key? key}) : super(key: key);
  @override
  _RecordDombaState createState() => _RecordDombaState();
}

class _RecordDombaState extends State<RecordDomba> {
  final TextEditingController _kodeDombaController = TextEditingController();
  String? _kodeDombaInput;
  Map<String, dynamic>? _kodeDombaData;
  List<Map<String, dynamic>>? _dataKawin;
  List<Map<String, dynamic>>? _dataBunting;
  List<Map<String, dynamic>>? _dataBeranak;

  @override
  Widget build(BuildContext context) {
    double borderWidth = 2.0;
    double totalBorderWidth = borderWidth * 2;
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: SafeArea(
        top: true,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 100.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'lib/images/bgbatik.png',
                  fit: BoxFit.cover,
                ),
                title: Text('Record Data Domba'),
                centerTitle: true,
              ),
              leading: IconButton(
                icon: Image.asset('lib/images/back.png', width: 24, height: 24),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              floating: true,
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('record_kawin')
                    .doc(user!.uid)
                    .collection('dataKawin')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> kawinSnapshot) {
                  if (kawinSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  var kawinData = kawinSnapshot.data!.docs;

                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('record_bunting')
                        .doc(user.uid)
                        .collection('dataBunting')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot> buntingSnapshot) {
                      if (buntingSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      var buntingData = buntingSnapshot.data!.docs;

                      return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('record_beranak')
                            .doc(user.uid)
                            .collection('dataBeranak')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> beranakSnapshot) {
                          if (beranakSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          var beranakData = beranakSnapshot.data!.docs;

                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                margin: EdgeInsets.only(left: 10, right: 10),
                                height: 148,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Rekap Kondisi Domba",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(117, 117, 117, 1),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              height: 59,
                                              width: 59,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color.fromARGB(
                                                    239, 40, 54, 42),
                                              ),
                                              child: Text(
                                                kawinData.length.toString(),
                                                style: TextStyle(
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "Kawin",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    117, 117, 117, 1),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              height: 59,
                                              width: 59,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color.fromARGB(
                                                    255, 255, 104, 104),
                                              ),
                                              child: Text(
                                                buntingData.length.toString(),
                                                style: TextStyle(
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "Bunting",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    117, 117, 117, 1),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              height: 59,
                                              width: 59,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color.fromARGB(
                                                    255, 255, 209, 60),
                                              ),
                                              child: Text(
                                                beranakData.length.toString(),
                                                style: TextStyle(
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "Beranak",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    117, 117, 117, 1),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DombaKawin()),
                                          );
                                        },
                                        style: ButtonStyle(
                                          minimumSize:
                                              WidgetStateProperty.all<Size>(
                                                  Size(400, 55)),
                                          padding: WidgetStateProperty.all<
                                                  EdgeInsetsGeometry>(
                                              EdgeInsets.all(12)),
                                          backgroundColor:
                                              WidgetStateProperty.all<Color>(
                                                  Color.fromRGBO(
                                                      0, 163, 255, 1)),
                                          shape: WidgetStateProperty.all<
                                              OutlinedBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          elevation:
                                              WidgetStateProperty.all<double>(
                                                  15),
                                          shadowColor:
                                              WidgetStateProperty.all<Color>(
                                                  Colors.black
                                                      .withOpacity(1)),
                                        ),
                                        child: Text(
                                          'Tambah Domba Kawin',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DombaHamil()),
                                          );
                                        },
                                        style: ButtonStyle(
                                          minimumSize:
                                              WidgetStateProperty.all<Size>(
                                                  Size(400, 55)),
                                          padding: WidgetStateProperty.all<
                                                  EdgeInsetsGeometry>(
                                              EdgeInsets.all(12)),
                                          backgroundColor:
                                              WidgetStateProperty.all<Color>(
                                                  Color.fromRGBO(
                                                      0, 163, 255, 1)),
                                          shape: WidgetStateProperty.all<
                                              OutlinedBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          elevation:
                                              WidgetStateProperty.all<double>(
                                                  15),
                                          shadowColor:
                                              WidgetStateProperty.all<Color>(
                                                  Colors.black
                                                      .withOpacity(1)),
                                        ),
                                        child: Text(
                                          'Tambah Domba Bunting',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DombaChild()),
                                          );
                                        },
                                        style: ButtonStyle(
                                          minimumSize:
                                              WidgetStateProperty.all<Size>(
                                                  Size(400, 55)),
                                          padding: WidgetStateProperty.all<
                                                  EdgeInsetsGeometry>(
                                              EdgeInsets.all(12)),
                                          backgroundColor:
                                              WidgetStateProperty.all<Color>(
                                                  Color.fromRGBO(
                                                      0, 163, 255, 1)),
                                          shape: WidgetStateProperty.all<
                                              OutlinedBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          elevation:
                                              WidgetStateProperty.all<double>(
                                                  15),
                                          shadowColor:
                                              WidgetStateProperty.all<Color>(
                                                  Colors.black
                                                      .withOpacity(1)),
                                        ),
                                        child: Text(
                                          'Tambah Domba Beranak',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(0),
                                      padding: EdgeInsets.all(
                                          totalBorderWidth + 10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.black,
                                            width: borderWidth),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Cari domba',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 1),
                                                  ),
                                                ),
                                              ]),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.06,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color
                                                              .fromARGB(255,
                                                              158, 158, 158)
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextField(
                                                        controller:
                                                            _kodeDombaController,
                                                        decoration: InputDecoration(
                                                            hintText: 'Kode',
                                                            border:
                                                                InputBorder
                                                                    .none,
                                                            contentPadding:
                                                                EdgeInsets.symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        20),
                                                            isDense: true,
                                                            alignLabelWithHint:
                                                                true,
                                                            hintStyle: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        117,
                                                                        117,
                                                                        117,
                                                                        100))),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _kodeDombaInput =
                                                                value.trim();
                                                          });
                                                        },
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 2),
                                              ElevatedButton(
                                                onPressed: () {
                                                  _searchDomba();
                                                },
                                                style: ButtonStyle(
                                                  minimumSize:
                                                      WidgetStateProperty
                                                          .resolveWith(
                                                              (states) {
                                                    final screenWidth =
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width;
                                                    final buttonWidth =
                                                        screenWidth * 0.3;
                                                    return Size(
                                                        buttonWidth, 55);
                                                  }),
                                                  padding: WidgetStateProperty
                                                      .all<EdgeInsetsGeometry>(
                                                          EdgeInsets.all(12)),
                                                  backgroundColor:
                                                      WidgetStateProperty.all<
                                                              Color>(
                                                          Color.fromRGBO(0,
                                                              163, 255, 1)),
                                                  shape: WidgetStateProperty
                                                      .all<OutlinedBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(10),
                                                    ),
                                                  ),
                                                  elevation:
                                                      WidgetStateProperty.all<
                                                          double>(15),
                                                  shadowColor:
                                                      WidgetStateProperty.all<
                                                              Color>(
                                                          Colors.black
                                                              .withOpacity(
                                                                  1)),
                                                ),
                                                child: Text(
                                                  'Cari',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                            child: Column(
                                              mainAxisSize:
                                                  MainAxisSize.min,
                                              children: [
                                                GridView.count(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 10,
                                                  mainAxisSpacing: 10,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  childAspectRatio:
                                                      (88 / 22),
                                                  children: [
                                                    _buildNumberBox(
                                                        'Kode Domba ',
                                                        _kodeDombaData?[
                                                                'kodeDomba'] ??
                                                            '',
                                                        'lib/images/tag.png'),
                                                    _buildNumberBox(
                                                        'Bobot (kg) : ',
                                                        _kodeDombaData?[
                                                                'bobotDomba'] ??
                                                            '',
                                                        'lib/images/scale.png'),
                                                    _buildNumberBox(
                                                        'Umur (Bulan) : ',
                                                        _kodeDombaData?[
                                                                'umurDomba'] ??
                                                            '',
                                                        'lib/images/age.png'),
                                                    _buildNumberBox(
                                                        '',
                                                        _kodeDombaData?[
                                                                'jenisKelamin'] ??
                                                            '',
                                                        'lib/images/gen.png'),
                                                  ],
                                                ),
                                                SizedBox(height: 20)
                                              ],
                                            ),
                                          ),
                                          
                                          Text(
                                            'Domba Kawin',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          if (_dataKawin != null &&
                                              _dataKawin!.isNotEmpty)
                                            Table(
                                              border: TableBorder.all(
                                                color: Colors.black,
                                                style: BorderStyle.solid,
                                                width: borderWidth,
                                              ),
                                              children: [
                                                TableRow(children: [
                                                  _buildTableHeader(
                                                      'Tanggal',
                                                      Color.fromARGB(
                                                          239, 40, 54, 42)),
                                                  _buildTableHeader(
                                                      'Urutan Kawin',
                                                      Color.fromARGB(
                                                          239, 40, 54, 42)),
                                                ]),
                                                if (_dataKawin != null)
                                                  ..._dataKawin!.map((data) =>
                                                      TableRow(children: [
                                                        _buildTableText(
                                                            _formatDate(data[
                                                                'tanggalKawin']),
                                                            Colors.white),
                                                        _buildTableText(
                                                            data['urutanKawin']
                                                                .toString(),
                                                            Colors.white),
                                                      ])),
                                              ],
                                            ),
                                          if (_dataKawin != null &&
                                              _dataKawin!.isEmpty)
                                            Text(
                                              'Tidak ada data',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.red,
                                              ),
                                            ),
                                          SizedBox(height: 20),
                                          Text(
                                            'Domba Bunting',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          if (_dataBunting != null &&
                                              _dataBunting!.isNotEmpty)
                                            Table(
                                              border: TableBorder.all(
                                                color: Colors.black,
                                                style: BorderStyle.solid,
                                                width: borderWidth,
                                              ),
                                              children: [
                                                TableRow(children: [
                                                  _buildTableHeader(
                                                      'Tanggal',
                                                      Color.fromARGB(255, 255,
                                                          104, 104)),
                                                  _buildTableHeader(
                                                      'Urutan Bunting',
                                                      Color.fromARGB(255, 255,
                                                          104, 104)),
                                                ]),
                                                if (_dataBunting != null)
                                                  ..._dataBunting!.map(
                                                      (data) =>
                                                          TableRow(children: [
                                                            _buildTableText(
                                                                _formatDate(data[
                                                                    'tanggalBunting']),
                                                                Colors.white),
                                                            _buildTableText(
                                                                data['urutanBunting']
                                                                    .toString(),
                                                                Colors.white),
                                                          ])),
                                              ],
                                            ),
                                          if (_dataBunting != null &&
                                              _dataBunting!.isEmpty)
                                            Text(
                                              'Tidak ada data',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.red,
                                              ),
                                            ),
                                          SizedBox(height: 20),
                                          Text(
                                            'Domba Beranak',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          if (_dataBeranak != null &&
                                              _dataBeranak!.isNotEmpty)
                                            Table(
                                              border: TableBorder.all(
                                                color: Colors.black,
                                                style: BorderStyle.solid,
                                                width: borderWidth,
                                              ),
                                              children: [
                                                TableRow(children: [
                                                  _buildTableHeader(
                                                      'Tanggal',
                                                      Color.fromARGB(
                                                          255, 255, 209, 60)),
                                                  _buildTableHeader(
                                                      'Urutan Beranak',
                                                      Color.fromARGB(
                                                          255, 255, 209, 60)),
                                                  _buildTableHeader(
                                                      'Jumlah Anak',
                                                      Color.fromARGB(
                                                          255, 255, 209, 60)),
                                                ]),
                                                if (_dataBeranak != null)
                                                  ..._dataBeranak!.map(
                                                      (data) =>
                                                          TableRow(children: [
                                                            _buildTableText(
                                                                _formatDate(data[
                                                                    'tanggalBeranak']),
                                                                Colors.white),
                                                            _buildTableText(
                                                                data['urutanBeranak']
                                                                    .toString(),
                                                                Colors.white),
                                                            _buildTableText(
                                                                data['jumlahAnak']
                                                                    .toString(),
                                                                Colors.white),
                                                          ])),
                                              ],
                                            ),
                                          if (_dataBeranak != null &&
                                              _dataBeranak!.isEmpty)
                                            Text(
                                              'Tidak ada data',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.red,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 100),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: navigasi(),
    );
  }

  Widget _buildTableHeader(String text, Color tableHeader) {
    return TableCell(
      child: Container(
        padding: EdgeInsets.all(10.0),
        color: tableHeader,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: const Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildTableText(String text, Color backgroundColor) {
    return TableCell(
      child: Container(
        padding: EdgeInsets.all(8.0),
        color: backgroundColor,
        child: FractionallySizedBox(
          widthFactor: 1.0,
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Future<void> _searchDomba() async {
    final kodeDombaInput = _kodeDombaInput;
    if (kodeDombaInput != null && kodeDombaInput.isNotEmpty) {
      final User? user = FirebaseAuth.instance.currentUser;
      final CollectionReference dataDombaCollection = FirebaseFirestore.instance
          .collection('domba')
          .doc(user!.uid)
          .collection('dataDomba');
      final snapshot = await dataDombaCollection
          .where('kodeDomba', isEqualTo: kodeDombaInput)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        final dataDomba = snapshot.docs.first.data();
        setState(() {
          _kodeDombaData = dataDomba as Map<String, dynamic>?;
        });
        await _fetchDataKawin(user.uid, kodeDombaInput);
        await _fetchDataBunting(user.uid, kodeDombaInput);
        await _fetchDataBeranak(user.uid, kodeDombaInput);
      } else {
        setState(() {
          _kodeDombaData = null;
          _dataKawin = null;
          _dataBunting = null;
          _dataBeranak = null;
        });
      }
    } else {
      setState(() {
        _kodeDombaData = null;
        _dataKawin = null;
        _dataBunting = null;
        _dataBeranak = null;
      });
    }
  }

  Future<void> _fetchDataKawin(String userId, String kodeDomba) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('record_kawin')
        .doc(user!.uid)
        .collection('dataKawin')
        .where('kodeDomba', isEqualTo: kodeDomba)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final List<Map<String, dynamic>> dataKawin = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      for (int i = 0; i < dataKawin.length; i++) {
        dataKawin[i]['urutanKawin'] = i + 1;
      }
      setState(() {
        _dataKawin = dataKawin;
      });
    } else {
      setState(() {
        _dataKawin = [];
      });
    }
  }

  Future<void> _fetchDataBunting(String userId, String kodeDomba) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('record_bunting')
        .doc(user!.uid)
        .collection('dataBunting')
        .where('kodeDomba', isEqualTo: kodeDomba)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final List<Map<String, dynamic>> dataBunting = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      for (int i = 0; i < dataBunting.length; i++) {
        dataBunting[i]['urutanBunting'] = i + 1;
      }
      setState(() {
        _dataBunting = dataBunting;
      });
    } else {
      setState(() {
        _dataBunting = [];
      });
    }
  }

  Future<void> _fetchDataBeranak(String userId, String kodeDomba) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('record_beranak')
        .doc(user!.uid)
        .collection('dataBeranak')
        .where('kodeDomba', isEqualTo: kodeDomba)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final List<Map<String, dynamic>> dataBeranak = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      for (int i = 0; i < dataBeranak.length; i++) {
        dataBeranak[i]['jumlahAnak'] = i + 1;
      }
      setState(() {
        _dataBeranak = dataBeranak;
      });
    } else {
      setState(() {
        _dataBeranak = [];
      });
    }
  }

  String _formatDate(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  Widget _buildNumberBox(String title, String value, String image) {
    String jenisKelaminText = '';
    if (value == 'MJdiCLP726Un0p4A8vu2') {
      jenisKelaminText = 'Betina';
    } else if (value == 'SQ7e1oe2XtoQCQRYOQXe') {
      jenisKelaminText = 'Jantan';
    } else {
      jenisKelaminText = value;
    }
    return Container(
      width: 171,
      height: 32,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            margin: EdgeInsets.all(5),
            child: Image.asset(
              image,
              width: 32,
              height: 32,
            ),
          ),
          SizedBox(width: 5),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 5),
          Text(
            jenisKelaminText,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
