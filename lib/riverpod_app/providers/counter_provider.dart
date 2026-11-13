
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterState {
  final int counter;
  final int elapsedSeconds;
  final bool isRunning;
  final AppLifecycleState lifecycleState;

  const CounterState({
    this.counter = 0,
    this.elapsedSeconds = 0,
    this.isRunning = false,
    this.lifecycleState = AppLifecycleState.resumed,
  });

  CounterState copyWith({
    int? counter,
    int? elapsedSeconds,
    bool? isRunning,
    AppLifecycleState? lifecycleState,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      isRunning: isRunning ?? this.isRunning,
      lifecycleState: lifecycleState ?? this.lifecycleState,
    );
  }
}

class CounterNotifier extends Notifier<CounterState>
    with WidgetsBindingObserver {
  Timer? _timer;

  @override
  CounterState build() {
    WidgetsBinding.instance.addObserver(this);

    ref.onDispose(() {
      _timer?.cancel();
      WidgetsBinding.instance.removeObserver(this);
    });

    return const CounterState();
  }

  void increment() {
    state = state.copyWith(counter: state.counter + 1);
  }

  void decrement() {
    if (state.counter > 0) {
      state = state.copyWith(counter: state.counter - 1);
    }
  }

  void resetCounter() {
    state = state.copyWith(counter: 0);
  }

  void startTimer() {
    if (state.isRunning) return;

    state = state.copyWith(isRunning: true);

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        state = state.copyWith(
          elapsedSeconds: state.elapsedSeconds + 1,
        );
      },
    );
  }

  void pauseTimer() {
    _timer?.cancel();
    _timer = null;
    state = state.copyWith(isRunning: false);
  }

  void resumeTimer() {
    if (!state.isRunning) {
      startTimer();
    }
  }

  void resetTimer() {
    pauseTimer();
    state = state.copyWith(elapsedSeconds: 0);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    this.state = this.state.copyWith(lifecycleState: state);

    if (state != AppLifecycleState.resumed) {
      pauseTimer();
    }
  }
}

final counterProvider =
    NotifierProvider<CounterNotifier, CounterState>(
  CounterNotifier.new,
);
