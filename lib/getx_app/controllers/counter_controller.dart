
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CounterController extends GetxController
    with WidgetsBindingObserver {

  // Counter State
  final RxInt counter = 0.obs;

  // Timer State
  final RxInt elapsedSeconds = 0.obs;
  final RxBool isRunning = false.obs;

  // App Lifecycle State
  final Rx<AppLifecycleState> lifecycleState =
      AppLifecycleState.resumed.obs;

  Timer? _timer;

  // Initialize Controller
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  // Counter Functions
  void increment() {
    counter.value++;
  }

  void decrement() {
    if (counter.value > 0) {
      counter.value--;
    }
  }

  void resetCounter() {
    counter.value = 0;
  }

  // Timer Functions
  void startTimer() {
    if (isRunning.value) return;

    isRunning.value = true;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        elapsedSeconds.value++;
      },
    );
  }

  void pauseTimer() {
    _timer?.cancel();
    _timer = null;
    isRunning.value = false;
  }

  void resumeTimer() {
    if (isRunning.value) return;

    startTimer();
  }

  void resetTimer() {
    pauseTimer();
    elapsedSeconds.value = 0;
  }

  // App Lifecycle Management
  @override
  void didChangeAppLifecycleState(
      AppLifecycleState state) {

    lifecycleState.value = state;

    if (state != AppLifecycleState.resumed) {
      pauseTimer();
    }
  }

  // Dispose Resources
  @override
  void onClose() {
    _timer?.cancel();
    _timer = null;

    WidgetsBinding.instance.removeObserver(this);

    super.onClose();
  }
}
