import 'dart:async';

import 'package:timer/abstract_state.dart';
import 'package:timer/cronometer_manager.dart';

class RunState implements StateBase {
  Timer? _timer;

  @override
  void execute() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      CronometerManager.incrementSeconds();
      CronometerManager.addStreamEvent();
    });
    CronometerManager.timer = _timer;
  }
}
