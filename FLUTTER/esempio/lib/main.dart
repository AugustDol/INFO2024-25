import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CIAO!',
              style: TextStyle(
                fontSize: 50.0,
                color: Color.fromARGB(255, 237, 111, 153),
              ),
            ),
            Text(
              'SUCA!!',
              style: TextStyle(
                fontSize: 50.0,
                color: Color.fromARGB(255, 68, 221, 21),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'WOOO',
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Color.fromARGB(255, 60, 10, 188),
                  ),
                ),
                Text(
                  'OOO',
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Color.fromARGB(255, 188, 10, 10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ));
}
