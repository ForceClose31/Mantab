import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first/providers/login/login_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nomorAnggotaController = TextEditingController();
  final TextEditingController kataSandiController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('lib/images/bglogreg.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: constraints.maxHeight * 0.35,
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Halaman Masuk',
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
                      padding: const EdgeInsets.only(
                        top: 200,
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/images/logo.png',
                            width: 250,
                            height: 150,
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 10), 
                                  child: Text(
                                    'Nomor Anggota Kelompok',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromRGBO(117, 117, 117, 1)),
                                  ),
                                ),
                                Container(
                                  height: 55, 
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                                255, 158, 158, 158)
                                            .withOpacity(0.5),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                    color: Colors
                                        .white, 
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextField(
                                          controller: nomorAnggotaController,
                                          decoration: InputDecoration(
                                              hintText:
                                                  'Nomor Anggota Kelompok',
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                              isDense: true,
                                              alignLabelWithHint: true,
                                              hintStyle: TextStyle(
                                                  color: Color.fromRGBO(
                                                      117, 117, 117, 100))),
                                          textAlign: TextAlign
                                              .left, 
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 10), 
                                  child: Text(
                                    'Kata Sandi',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromRGBO(117, 117, 117, 1)),
                                  ),
                                ),
                                Container(
                                  height: 55, 
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                                255, 158, 158, 158)
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
                                          MainAxisAlignment.center,
                                      children: [
                                        TextField(
                                          controller: kataSandiController,
                                          obscureText: !isPasswordVisible,
                                          decoration: InputDecoration(
                                            hintText: 'Kata Sandi',
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 20),
                                            isDense: true,
                                            alignLabelWithHint: true,
                                            hintStyle: TextStyle(
                                                color: Color.fromRGBO(
                                                    117, 117, 117, 100)),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                isPasswordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  isPasswordVisible =
                                                      !isPasswordVisible;
                                                });
                                              },
                                            ),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ), 
                                ElevatedButton(
                                  onPressed: () {
                                    final String email =
                                        '${nomorAnggotaController.text}@yourdomain.com';
                                    final String password =
                                        kataSandiController.text;

                                    context
                                        .read<LoginProvider>()
                                        .loginUser(context, email, password);
                                  },
                                  style: ButtonStyle(
                                    minimumSize: WidgetStateProperty.all<Size>(
                                        Size(180, 60)), 
                                    padding: WidgetStateProperty.all<
                                            EdgeInsetsGeometry>(
                                        EdgeInsets.all(12)), 
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            Color.fromRGBO(78, 59, 33, 1)),
                                    shape:
                                        WidgetStateProperty.all<OutlinedBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), 
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Masuk',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            18 
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
