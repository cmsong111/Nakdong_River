import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nakdong_river/data/repository_firebase.dart';
import 'package:nakdong_river/domain/position.dart';
import 'package:nakdong_river/domain/repository.dart';
import 'package:nakdong_river/firebase_options.dart';

import 'presentation/views/my_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
