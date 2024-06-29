import 'package:first/screens/navigasi/navigasi.dart';
import 'package:first/screens/ransum/screen/tambahransum.dart';
import 'package:first/screens/recordDomba/screen/recordDomba.dart';
import 'package:first/screens/tambahDomba/screen/tambahdomba.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<String> youtubeVideoIds = [
    '9m9aqlz6Otc',
    '0yOrZ786JSA',
    'x0vOMsSEnPI',
    'KGWjXjUZNkE',
    'VnL0CJoFC7Q',
  ];
  late List<YoutubePlayerController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = youtubeVideoIds
        .map((videoId) => YoutubePlayerController(
              initialVideoId: videoId,
              flags: YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
              ),
            ))
        .toList();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Stack(
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
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 33.0),
                            Container(
                              width: 395,
                              height: 91,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user!.uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData ||
                                      snapshot.data == null) {
                                    return const CircularProgressIndicator();
                                  }
                                  var userData = snapshot.data!.get('nama');
                                  if (userData == null) {
                                    return const CircularProgressIndicator();
                                  }
                                  return Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8, left: 8),
                                                  child: Text(
                                                    'Selamat Datang',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            78, 59, 33, 1)),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: CircleAvatar(
                                                        radius: 20,
                                                        backgroundImage: AssetImage(
                                                            'lib/images/PP.png'),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4),
                                                      child: Text(
                                                        userData ??
                                                            'Nama Pengguna',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    78,
                                                                    59,
                                                                    33,
                                                                    1)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          onPressed: () {
                                            // Tambahkan fungsi notifikasi di sini
                                          },
                                          icon: const Icon(Icons.notifications,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: 395,
                              height: 147,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromRGBO(94, 68, 55, 1),
                                    Color.fromRGBO(104, 119, 68, 1),
                                  ],
                                  stops: [0.0, 0.8],
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Layanan",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CreateDomba()),
                                                );
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 63.0,
                                                    width: 63.0,
                                                    child: Image.asset(
                                                        'lib/images/domba.png'),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10.0),
                                                    child: Text(
                                                      "Tambah domba",
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RecordDomba()),
                                                );
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 63.0,
                                                    width: 63.0,
                                                    child: Image.asset(
                                                        'lib/images/record.png'),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10.0),
                                                    child: Text(
                                                      "Record domba",
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CreateRansum()),
                                                );
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 63.0,
                                                    width: 63.0,
                                                    child: Image.asset(
                                                        'lib/images/ransum.png'),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10.0),
                                                    child: Text(
                                                      "Ransum",
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Tips and Tricks',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ..._controllers.asMap().entries.map(
                                  (entry) {
                                    int index = entry.key;
                                    YoutubePlayerController controller =
                                        entry.value;
                                    return VisibilityDetector(
                                      key: Key('youtube-player-$index'),
                                      onVisibilityChanged: (info) {
                                        if (info.visibleFraction == 0) {
                                          controller.pause();
                                        }
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              // border: Radius.circular(radius),
                                              color: Colors.grey[300],
                                            ),
                                            child: YoutubePlayer(
                                              controller: controller,
                                              showVideoProgressIndicator: false,
                                              progressIndicatorColor:
                                                  Colors.red,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ).toList(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: navigasi(),
    );
  }
}
