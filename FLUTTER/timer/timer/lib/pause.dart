import 'package:timer/abstract_state.dart';
import 'package:timer/cronometer_manager.dart';

class StopState implements StateBase {
  @override
  void execute() {
    CronometerManager.stop();
  }
}
