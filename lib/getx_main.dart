
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'getx_app/screens/getx_screen.dart';

void main() {
  runApp(const GetXApp());
}

class GetXApp extends StatelessWidget {
  const GetXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Interactive Counter - GetX',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF604477),
        ),
      ),
      home: GetxScreen(),
    );
  }
}
