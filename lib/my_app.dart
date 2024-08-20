import 'package:flutter/material.dart';
import 'package:tasksm_app/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TasksM',
      home: HomeScreen(),
    );
  }
}
