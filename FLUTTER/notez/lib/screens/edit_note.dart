import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notez/models/note.dart' as n;
import 'package:notez/provider/note.dart';

class EditNote extends ConsumerStatefulWidget {
  const EditNote({super.key, required int id}) : _id = id;

  final int _id;

  @override
  ConsumerState<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends ConsumerState<EditNote> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _title = '';
  String _text = '';

  @override
  void initState() {
    super.initState();

    final n.Note note = ref.read(noteProvider.notifier).get(widget._id);
    _titleController.text = note.title;
    _descriptionController.text = note.text;
  }

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
                      controller: _titleController,
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
                      controller: _descriptionController,
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
                          
                          ref.read(noteProvider.notifier).put(widget._id, _title, _text);

                          context.pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50)
                      ),
                      icon: const Icon(Icons.edit),
                      label: const Text('Modifica'),
                    )
                  ],
                ),
              )
            )
          ], 
        )
      ),
    );
  }
}