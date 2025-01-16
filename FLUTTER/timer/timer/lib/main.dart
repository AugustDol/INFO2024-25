import 'package:flutter/material.dart';
import 'package:timer/preview.dart';

void main() => runApp(const Main());

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Timer :)",
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 21, 237, 21)),
          useMaterial3: true),
      home: const HomePage(),
    );
  }
}
