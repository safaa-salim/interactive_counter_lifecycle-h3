
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'riverpod_app/screens/riverpod_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: RiverpodApp(),
    ),
  );
}

class RiverpodApp extends StatelessWidget {
  const RiverpodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Interactive Counter - Riverpod',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF604477),
        ),
      ),
      home: const RiverpodScreen(),
    );
  }
}
