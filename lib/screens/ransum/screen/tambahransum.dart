import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/screens/navigasi/navigasi.dart';
import 'package:flutter/material.dart';


class CreateRansum extends StatefulWidget {
  @override
  _CreateRansumState createState() => _CreateRansumState();
}

class _CreateRansumState extends State<CreateRansum> {
  late List<double> totalResults;
  @override
  void initState() {
    super.initState();
    initializeTotalResults();
  }

  void initializeTotalResults() {
    totalResults = [0, 0, 0, 0, 0, 0]; 
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

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
              top: 25, 
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
                  SizedBox(height: 10), 
                ],
              ),
            ),

            
            Positioned(
              top: 70,
              left: 15,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Data Domba',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),

            Positioned(
              top: 130,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color.fromRGBO(78, 59, 33, 1)),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Kebutuhan Pakan Keseluruhan Hari Ini',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(117, 117, 117, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('domba')
                          .doc(user!.uid)
                          .collection('dataDomba')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        if (snapshot.data!.docs.isEmpty) {
                          return Text('No data available');
                        }

                        
                        initializeTotalResults();

                        snapshot.data!.docs
                            .forEach((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          double bobot = double.parse(data['bobotDomba']);
                          double result2Value = 0.15 * bobot * 0.122;
                          double result3Value = 0.15 * bobot * 0.685;
                          double result4Value = 0.15 * bobot * 0.027;
                          double result5Value = 0.15 * bobot * 0.01;
                          double result6Value = 0.15 * bobot * 0.071;
                          double result7Value = 0.15 * bobot * 0.112;

                          totalResults[0] += result2Value;
                          totalResults[1] += result3Value;
                          totalResults[2] += result4Value;
                          totalResults[3] += result5Value;
                          totalResults[4] += result6Value;
                          totalResults[5] += result7Value;
                        });

                        return GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          childAspectRatio: (171 / 22),
                          children: [
                            _buildNumberBox('Tumpi jagung : ', totalResults[0],
                                Color.fromRGBO(159, 131, 19, 1)),
                            _buildNumberBox('Rumput gajah : ', totalResults[1],
                                Color.fromRGBO(32, 113, 26, 1)),
                            _buildNumberBox('Ampas tebu : ', totalResults[2],
                                Color.fromRGBO(33, 73, 121, 1)),
                            _buildNumberBox('Molases : ', totalResults[3],
                                Color.fromRGBO(139, 121, 47, 1)),
                            _buildNumberBox('Rumput lapang : ', totalResults[4],
                                Color.fromRGBO(13, 71, 35, 1)),
                            _buildNumberBox('Bekatul : ', totalResults[5],
                                Color.fromRGBO(111, 92, 12, 1)),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 20)
                  ],
                ),
              ),
            ),
            
            Positioned(
              top: 310,
              left: -15,
              right: -15,
              bottom: 50,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  child: Column(
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('domba')
                            .doc(user.uid)
                            .collection('dataDomba')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }

                          if (snapshot.data!.docs.isEmpty) {
                            return Text('No data available');
                          }

                          
                          List<DocumentSnapshot> sortedDocs =
                              snapshot.data!.docs;
                          sortedDocs.sort((a, b) =>
                              a['kodeDomba'].compareTo(b['kodeDomba']));

                          return Column(
                            children:
                                sortedDocs.map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data() as Map<String, dynamic>;
                              return Column(
                                children: [
                                  _buildItem(
                                    kodeDomba: data['kodeDomba'],
                                    result1: data[
                                        'bobotDomba'], 
                                    result2: '', 
                                    result3: '',
                                    result4: '',
                                    result5: '',
                                    result6: '',
                                    result7: '',
                                    result8: '',
                                  ),
                                  SizedBox(height: 10),
                                ],
                              );
                            }).toList(),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                    ],
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

  Widget _buildItem({
    required String kodeDomba,
    required String result1,
    required String result2,
    required String result3,
    required String result4,
    required String result5,
    required String result6,
    required String result7,
    required String result8,
  }) {
    double bobot = double.parse(result1);
    double result2Value = 0.15 * bobot * 0.122;
    double result3Value = 0.15 * bobot * 0.685;
    double result4Value = 0.15 * bobot * 0.027;
    double result5Value = 0.15 * bobot * 0.01;
    double result6Value = 0.15 * bobot * 0.071;
    double result7Value = 0.15 * bobot * 0.112;
    double result8Value = result2Value + result3Value + result4Value + result5Value + result6Value + result7Value;
    
    totalResults[0] += result2Value;
    totalResults[1] += result3Value;
    totalResults[2] += result4Value;
    totalResults[3] += result5Value;
    totalResults[4] += result6Value;
    totalResults[5] += result7Value;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.only(bottom: 10),
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
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                kodeDomba,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bobot : $result1',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Tumpi jagung : ${result2Value.toStringAsFixed(3)}', 
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Rumput gajah : ${result3Value.toStringAsFixed(3)}', 
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Ampas tebu : ${result4Value.toStringAsFixed(3)}', 
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Molases : ${result5Value.toStringAsFixed(3)}', 
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Rumput lapang : ${result6Value.toStringAsFixed(3)}', 
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Bekatul : ${result7Value.toStringAsFixed(3)}', 
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Total Kebutuhan Domba : ${result8Value.toStringAsFixed(3)}', 
                  style: TextStyle(
                    fontSize: 12,
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
    );
  }

  Widget _buildNumberBox(String title, double value, colors) {
    return Container(
      width: 171,
      height: 32,
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title, 
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            value.toStringAsFixed(3), 
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ],
      ),
    );
  }
}
