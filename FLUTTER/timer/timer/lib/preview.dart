import 'dart:async';

import 'package:timer/states.dart';
import 'package:timer/cronometer_manager.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StopState _stopState = StopState();
  final RunState _runState = RunState();
  final ResetState _resetState = ResetState();

  late StateBase _currentState;

  @override
  void initState() {
    super.initState();
    CronometerManager.streamController = StreamController<int>();
    _currentState = _stopState;
  }

  void changeState(StateBase newState) {
    if (_currentState.runtimeType == newState.runtimeType) {
      return;
    }

    setState(() {
      _currentState = newState;
    });
    _currentState.execute();
  }

  @override
  void dispose() {
    CronometerManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<int>(
          stream: CronometerManager.stream,
          initialData: CronometerManager.seconds,
          builder: (context, snapshot) {
            final int hour = CronometerManager.hours;
            final int minutes = CronometerManager.minutes;
            final int remainingSeconds = CronometerManager.elapsedSeconds;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                      fontSize: 48, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () => changeState(_runState),
                        child: const Icon(Icons.play_arrow)),
                    const SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: () => changeState(_stopState),
                        child: const Icon(Icons.pause)),
                    const SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: () => changeState(_resetState),
                        child: const Icon(Icons.restart_alt_rounded))
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
