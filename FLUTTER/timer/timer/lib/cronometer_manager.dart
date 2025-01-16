import 'dart:async';

class CronometerManager {
  static Timer? _timer;
  static late StreamController<int> _controller;
  static late Stream<int> _stream;
  static int _elapsedSeconds = 0;

  // Getters
  static int get elapsedSeconds => _elapsedSeconds;
  static int get hours => _elapsedSeconds ~/ 3600;
  static int get minutes => (_elapsedSeconds % 3600) ~/ 60;
  static int get seconds => _elapsedSeconds % 60;
  static Stream<int> get stream => _stream;

  // Setters
  static void incrementSeconds() => _elapsedSeconds++;
  static void addStreamEvent() => _controller.add(_elapsedSeconds);
  static void stop() => _timer?.cancel();

  // Dispose resources
  static void dispose() {
    _timer?.cancel();
    _controller.close();
  }

  // Set the stream controller
  static set streamController(StreamController<int> controller) {
    _controller = controller;
    _stream = _controller.stream;
  }

  // Reset the timer
  static void reset() {
    _elapsedSeconds = 0;
    addStreamEvent();
  }

  // Set timer
  static set timer(Timer? timer) {
    _timer = timer;
  }
}
