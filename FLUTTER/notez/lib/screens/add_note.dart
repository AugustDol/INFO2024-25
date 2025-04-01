import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notez/models/note.dart' as n;
import 'package:notez/provider/note.dart';

class AddNote extends ConsumerStatefulWidget {
  const AddNote({super.key});

  @override
  ConsumerState<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends ConsumerState<AddNote> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title = '';
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 25,
              )
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Titolo',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Inserisci un titolo';
                        }
                        return null;
                      },
                      onSaved: (newValue) => _title = newValue ?? '',
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Descrizione'
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Inserisci una descrizione';
                        }
                        return null;
                      },
                      onSaved: (newValue) => _text = newValue ?? '',
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          ref.read(noteProvider.notifier)
                            .add(n.Note(
                              title: _title,
                              text: _text,
                              red: Random().nextInt(106) + 150,
                              green: Random().nextInt(106) + 150,
                              blue: Random().nextInt(106) + 150
                            )
                          );
                          context.pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50)
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text('Aggiungi'),
                    )
                  ],
                ),
              )
            ),
          ],
        )
      ),
    );
  }
}