import 'package:notez/models/note.dart' as n;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:notez/objectbox.g.dart';

part 'note.g.dart';

@riverpod
class Note extends _$Note {
  late final Store _store;
  late final Box<n.Note> _box;

  @override
  Future<List<n.Note>> build() async {
    _store = await _initObjectBox();
    _box = _store.box<n.Note>();

    return await _box.getAllAsync();
  }

  Future<Store> _initObjectBox() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(appDocDir.path, 'objectbox');

    return openStore(directory: dbPath);
  }

  void add(n.Note note) {
    _box.put(note);
    state = AsyncValue.data([...state.value!, note]);
  }

  void delete(int id) {
    _box.remove(id);
    state = AsyncValue.data([...state.value!.where((note) => note.id != id)]);
  }

  n.Note get(int id) {
    return state.value!.firstWhere((note) => note.id == id);
  }

  void put(int id, String title, String description) {
    final note = get(id);
    note.title = title;
    note.text = description;
    _box.put(note);

    state = AsyncValue.data([...state.value!.where((note) => note.id != id), note]);
  }
}