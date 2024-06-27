import 'package:flutter/material.dart';

class navigasi extends StatelessWidget {
  const navigasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                icon: Image.asset(
                  'lib/images/home.png',
                  color: Color.fromARGB(255, 50, 96, 51),
                ),
                tooltip: 'Home',
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/schedule');
                },
                icon: Image.asset(
                  'lib/images/schedule.png',
                  color: Color.fromARGB(255, 50, 96, 51),
                ),
                tooltip: 'Schedule',
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/information');
                },
                icon: Image.asset(
                  'lib/images/info.png',
                  color: Color.fromARGB(255, 50, 96, 51),
                ),
                tooltip: 'Information',
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/profile');
                },
                icon: Image.asset(
                  'lib/images/profile.png',
                  color: Color.fromARGB(255, 50, 96, 51),
                ),
                tooltip: 'Profile',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
