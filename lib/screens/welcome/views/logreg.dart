import 'package:first/screens/login/views/login.dart';
import 'package:first/screens/register/views/registrasi.dart';
import 'package:flutter/material.dart';

class LogRegPage extends StatelessWidget {
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
                      image: AssetImage('lib/images/bglogreg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: constraints.maxHeight * 0.33, 
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 42), 
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                            CrossAxisAlignment.start, 
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0), 
                            child: Text(
                              'Selamat datang di MANTAB!',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            'Aplikasi berbasis mobile untuk memanajemen pemeliharaan dan ransum ternak domba.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10, 
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
                    SizedBox(
                      height: 10, 
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              minimumSize: WidgetStateProperty.all<Size>(
                                  Size(180, 50)), 
                              padding:
                                  WidgetStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.all(12)), 
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  Color.fromRGBO(78, 59, 33, 1)),
                              shape: WidgetStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), 
                                ),
                              ),
                            ),
                            child: Text(
                              'Masuk',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16 
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ), 
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegistrationPage(),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              minimumSize: WidgetStateProperty.all<Size>(
                                  Size(180, 50)), 
                              padding:
                                  WidgetStateProperty.all<EdgeInsetsGeometry>(
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
                              'Daftar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16 
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
          );
        },
      ),
    );
  }
}
