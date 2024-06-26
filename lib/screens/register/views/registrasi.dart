import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth/authentication_provider.dart';

class RegistrationPage extends StatelessWidget {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nomorAnggotaController = TextEditingController();
  final TextEditingController kataSandiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'lib/images/bglogreg.png'), // Ubah dengan path gambar background Anda
                      fit: BoxFit.cover, // Sesuaikan gambar dengan container
                    ),
                  ),
                  height: constraints.maxHeight * 0.3, // 1/3 dari tinggi layar
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Halaman Daftar',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: constraints.maxHeight * 0.3 +
                      20, // Adjust the top padding based on the height of the image
                  left: 20, // Menggeser tombol ke kiri
                  right: 20, // Menggeser tombol ke kanan
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/images/logo.png', // Ubah dengan path gambar logo Anda
                        width: 250,
                        height: 150,
                      ),
                      SizedBox(
                        height: 10, // Mengurangi jarak antara logo dan tombol
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10), // Tambahkan margin bawah
                              child: Text(
                                'Nama',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(117, 117, 117, 1)),
                              ),
                            ),
                            Container(
                              height: 55, // Atur tinggi container
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 158, 158, 158)
                                            .withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                                color:
                                    Colors.white, // Warna latar belakang putih
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextField(
                                      controller: namaController,
                                      decoration: InputDecoration(
                                          hintText: 'Nama',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          isDense: true,
                                          alignLabelWithHint: true,
                                          hintStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  117, 117, 117, 100))),
                                      textAlign: TextAlign
                                          .left, // Teks dalam TextField menjadi rata kiri
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
                                  bottom: 10), // Tambahkan margin bawah
                              child: Text(
                                'Nomor Anggota Kelompok',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(117, 117, 117, 1)),
                              ),
                            ),
                            Container(
                              height: 55, // Atur tinggi container
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 158, 158, 158)
                                            .withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                                color:
                                    Colors.white, // Warna latar belakang putih
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextField(
                                      controller: nomorAnggotaController,
                                      decoration: InputDecoration(
                                          hintText: 'Nomor Anggota Kelompok',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          isDense: true,
                                          alignLabelWithHint: true,
                                          hintStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  117, 117, 117, 100))),
                                      textAlign: TextAlign
                                          .left, // Teks dalam TextField menjadi rata kiri
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
                                  bottom: 10), // Tambahkan margin bawah
                              child: Text(
                                'Kata Sandi',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(117, 117, 117, 1)),
                              ),
                            ),
                            Container(
                              height: 55, // Atur tinggi container
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 158, 158, 158)
                                            .withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                                color:
                                    Colors.white, // Warna latar belakang putih
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextField(
                                      controller: kataSandiController,
                                      decoration: InputDecoration(
                                          hintText: 'Kata Sandi',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          isDense: true,
                                          alignLabelWithHint: true,
                                          hintStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  117, 117, 117, 100))),
                                      textAlign: TextAlign
                                          .left, // Teks dalam TextField menjadi rata kiri
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final String email =
                                    '${nomorAnggotaController.text}@yourdomain.com';
                                final String password =
                                    kataSandiController.text;
                                final String nama = namaController.text;
                                final int nomorAnggota =
                                    int.parse(nomorAnggotaController.text);

                                context
                                    .read<AuthenticationProvider>()
                                    .registerUser(context, email, password,
                                        nama, nomorAnggota);
                              },
                              style: ButtonStyle(
                                minimumSize: WidgetStateProperty.all<Size>(
                                    Size(180, 60)), // Ukuran minimum tombol
                                padding:
                                    WidgetStateProperty.all<EdgeInsetsGeometry>(
                                        EdgeInsets.all(12)), // Padding tombol
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    Color.fromRGBO(104, 119, 68, 1)),
                                shape: WidgetStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Atur border radius di sini
                                  ),
                                ),
                              ),
                              child: Text(
                                'Daftar',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        18 // Ubah warna teks menjadi putih
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
