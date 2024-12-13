import 'package:flutter/material.dart';
import 'package:hm_store/feature/main_app/presentation/screens/main_home_screen.dart';

import 'injection_container.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: MainHomeScreen(),
    );
  }
}
