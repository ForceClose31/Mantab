import 'package:first/providers/domba/tambah_provider.dart';
import 'package:first/providers/domba/ubah_provider.dart';
import 'package:first/providers/login/login_provider.dart';
import 'package:first/providers/record/kawin_provider.dart';
import 'package:first/screens/login/views/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:first/screens/profile/screen/halamanprofile.dart';
import 'package:first/screens/homepage/views/homepage.dart';
import 'package:first/screens/informasi/screen/maininformation.dart';
import 'package:first/screens/penjadwalan/screen/penjadwalan.dart';
import 'package:first/screens/welcome/views/logreg.dart';
import 'package:first/providers/auth/authentication_provider.dart';
import 'package:first/screens/register/views/registrasi.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  await AndroidAlarmManager.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _setupAlarmManager();
  }

  void _setupAlarmManager() async {
    final dombaProvider = Provider.of<DombaProvider>(context, listen: false);

    await AndroidAlarmManager.periodic(
      const Duration(days: 30),
      0,
      () async {
        await dombaProvider.updateSheepAge();
      },
      startAt: DateTime(DateTime.now().year, DateTime.now().month + 1, 1, 0, 0),
      exact: true,
      wakeup: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => DombaProvider()),
        ChangeNotifierProvider(create: (_) => UpdateDombaProvider()),
        ChangeNotifierProvider(create: (_) => DombaKawinProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => FutureBuilder<void>(
                future: _checkLoginStatus(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return snapshot.hasData ? Homepage() : LogRegPage();
                },
              ),
          '/welcome': (context) => LogRegPage(),
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

  Future<void> _checkLoginStatus(BuildContext context) async {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    await provider.checkLoginStatus(context);
  }
}
