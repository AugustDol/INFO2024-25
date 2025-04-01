import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notez/provider/note.dart';
import 'package:notez/router/router.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(noteProvider);

    return Scaffold(
      body: SafeArea(
        child: notes.value?.isNotEmpty ?? false ?
         ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: notes.value?.length,
          itemBuilder: (context, index) {
            final note = notes.value?[index];
            return SizedBox(
              height: MediaQuery.of(context).size.width,
              child: Card(
                color: note?.color,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text(note?.title ?? 'Errore'),
                    const SizedBox(height: 10),
                    Text(note?.text ?? 'Errore'),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            ref.read(noteProvider.notifier).delete(note!.id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.push('${RouteNames.editNote}/${note?.id}');
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),  
                        )
                      ] 
                    )
                  ],
                )
              ),
            );
          },
        ) : Container(
          margin: const EdgeInsets.only(top: 50),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Nessuna nota presente.')
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RouteNames.addNote);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}