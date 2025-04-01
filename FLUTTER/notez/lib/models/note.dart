import 'dart:ui';

import 'package:objectbox/objectbox.dart';

@Entity()
class Note {
  @Id()
  int id;
  String title;
  String text;
  int red;
  int green;
  int blue;

  Note({
    this.id = 0,
    required this.title,
    required this.text,
    required this.red,
    required this.green,
    required this.blue,
  });

  Color get color => Color.fromARGB(255, red, green, blue);
}