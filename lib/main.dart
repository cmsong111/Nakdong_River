import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nakdong_river/firebase_options.dart';
import 'package:nakdong_river/presentation/providers/admob_provider.dart';
import 'package:nakdong_river/presentation/providers/package_info_provider.dart';
import 'package:nakdong_river/presentation/providers/position_provider.dart';
import 'package:provider/provider.dart';

import 'presentation/views/my_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await MobileAds.instance.initialize();
  var storge = const FlutterSecureStorage();
  var code = await storge.read(key: 'position');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PositionProvider(code)),
        ChangeNotifierProvider(create: (_) => AdMobProvider()),
        ChangeNotifierProvider(create: (_) => PackageInfoProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
