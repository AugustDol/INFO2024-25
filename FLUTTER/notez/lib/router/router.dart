import 'package:go_router/go_router.dart';
import 'package:notez/extensions/string.dart';
import 'package:notez/screens/add_note.dart';
import 'package:notez/screens/edit_note.dart';
import 'package:notez/screens/home.dart';

class RouteNames {
  static const String home = '/';
  static const String addNote = '/add-note';
  static const String editNote = '/edit-note';
}

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: RouteNames.home,
    routes: [
      GoRoute(
        path: RouteNames.home,
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: RouteNames.addNote,
        builder: (context, state) => const AddNote(),
      ),
      GoRoute(
        path: '${RouteNames.editNote}/:id',
        builder: (context, state) =>  EditNote(id: state.pathParameters['id']!.toInt()),
      )
    ]
  );

  static GoRouter get router => _router;


}