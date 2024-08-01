import 'package:first/screens/tambahRecord/screen/dombaBeranak/dombaberanak.dart';
import 'package:first/screens/tambahRecord/screen/dombaBunting/dombabunting.dart';
import 'package:first/screens/tambahRecord/screen/dombaKawin/dombakawinn.dart';
import 'package:flutter/material.dart';

class buttonAddRecord extends StatelessWidget {
  const buttonAddRecord({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 300,
      left: 15,
      right: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DombaKawin()),
                  );
                },
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all<Size>(Size(400, 55)),
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(12)), 
                  backgroundColor: WidgetStateProperty.all<Color>(
                      Color.fromRGBO(0, 163, 255, 1)),
                  shape: WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), 
                    ),
                  ),
                  elevation:
                      WidgetStateProperty.all<double>(15), 
                  shadowColor: WidgetStateProperty.all<Color>(
                      Colors.black.withOpacity(1)), 
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
                    MaterialPageRoute(builder: (context) => DombaHamil()),
                  );
                },
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all<Size>(
                      Size(400, 55)), 
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(12)), 
                  backgroundColor: WidgetStateProperty.all<Color>(
                      Color.fromRGBO(0, 163, 255, 1)),
                  shape: WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), 
                    ),
                  ),
                  elevation:
                      WidgetStateProperty.all<double>(15), 
                  shadowColor: WidgetStateProperty.all<Color>(
                      Colors.black.withOpacity(1)),
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
                    MaterialPageRoute(builder: (context) => DombaChild()),
                  );
                },
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all<Size>(
                      Size(400, 55)), 
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(12)), 
                  backgroundColor: WidgetStateProperty.all<Color>(
                      Color.fromRGBO(0, 163, 255, 1)),
                  shape: WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), 
                    ),
                  ),
                  elevation:
                      WidgetStateProperty.all<double>(15), 
                  shadowColor: WidgetStateProperty.all<Color>(
                      Colors.black.withOpacity(1)),
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
    );
  }
}
