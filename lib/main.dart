import 'package:first/providers/login/login_provider.dart';
import 'package:first/screens/login/views/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:first/screens/profile/screen/halamanprofile.dart';
import 'package:first/screens/homepage/views/homepage.dart';
import 'package:first/screens/informasi/screen/maininformation.dart';
import 'package:first/screens/penjadwalan/screen/penjadwalan.dart';
import 'package:first/screens/welcome/views/logreg.dart';

import 'providers/auth/authentication_provider.dart';
import 'screens/register/views/registrasi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCx0JlWLE8mPh1jixILU0BfDeoKJ9gurrs',
      appId: '1:249132826909:android:54776866e54ed3435321f4',
      messagingSenderId: '249132826909',
      projectId: 'mantab-8e9eb',
      storageBucket: 'mantab-8e9eb.appspot.com',
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LogRegPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegistrationPage(),
          '/home': (context) => Homepage(),
          '/schedule': (context) => Penjadwalan(),
          '/information': (context) => InformationPage(),
          '/profile': (context) => HalamanProfile(),
        },
      ),
    );
  }
}
