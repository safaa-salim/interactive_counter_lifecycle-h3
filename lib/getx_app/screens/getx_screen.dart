
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/counter_controller.dart';

class GetxScreen extends StatelessWidget {
  GetxScreen({super.key});

  final CounterController controller =
      Get.put(CounterController());

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2FA),
      appBar: AppBar(
        title: const Text('Interactive Counter'),
        centerTitle: true,
        backgroundColor: const Color(0xFF604477),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'COUNTER',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Color(0xFF604477),
                ),
              ),
              const SizedBox(height: 15),

              // Counter Card
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      Obx(
                        () => Text(
                          '${controller.counter.value}',
                          style: const TextStyle(
                            fontSize: 65,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF604477),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: controller.decrement,
                            child: const Text('-1'),
                          ),
                          ElevatedButton(
                            onPressed: controller.increment,
                            child: const Text('+1'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: controller.resetCounter,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset Counter'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'STOPWATCH',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Color(0xFF604477),
                ),
              ),
              const SizedBox(height: 15),

              // Timer Card
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      Obx(
                        () => Text(
                          formatTime(
                            controller.elapsedSeconds.value,
                          ),
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF604477),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      Obx(
                        () => Text(
                          controller.isRunning.value
                              ? 'Running'
                              : 'Paused',
                          style: TextStyle(
                            color: controller.isRunning.value
                                ? Colors.green
                                : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          ElevatedButton(
                            onPressed: controller.startTimer,
                            child: const Text('Start'),
                          ),
                          ElevatedButton(
                            onPressed: controller.pauseTimer,
                            child: const Text('Pause'),
                          ),
                          ElevatedButton(
                            onPressed: controller.resumeTimer,
                            child: const Text('Resume'),
                          ),
                          OutlinedButton(
                            onPressed: controller.resetTimer,
                            child: const Text('Reset'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Lifecycle Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.phone_android,
                          color: Color(0xFF604477),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            'App Lifecycle: '
                            '${controller.lifecycleState.value.name}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
