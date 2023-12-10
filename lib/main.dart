import 'package:flutter/material.dart';
import 'package:internship_test/screens/post_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PostListScreen(),
    );
  }
}
