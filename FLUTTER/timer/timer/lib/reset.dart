import 'package:timer/abstract_state.dart';
import 'package:timer/cronometer_manager.dart';

class ResetState implements StateBase {
  @override
  void execute() {
    CronometerManager.stop();
    CronometerManager.reset();
  }
}
