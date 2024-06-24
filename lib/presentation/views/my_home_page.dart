import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nakdong_river/domain/position.dart';
import 'package:nakdong_river/presentation/providers/admob_provider.dart';
import 'package:nakdong_river/presentation/providers/position_provider.dart';
import 'package:nakdong_river/presentation/widgets/drawer.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("낙동", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          PopupMenuButton(
            onSelected: ((value) {
              context
                  .read<PositionProvider>()
                  .setPosition(Position.fromCode(value));
            }),
            itemBuilder: (BuildContext context) {
              return Position.values
                  .map((e) => PopupMenuItem(
                        value: e.code,
                        child: Text(e.name),
                      ))
                  .toList();
            },
            icon: const Icon(
              Icons.location_on,
              color: Colors.white,
            ),
          ),
        ],
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: const MyDrawer(),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: ListView(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                Text(
                  context.watch<PositionProvider>().measurement == null
                      ? "수온 정보 없음"
                      : "${context.watch<PositionProvider>().measurement!.temperature.roundToDouble()}°C",
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 1,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                ),
                Text(
                  context.watch<PositionProvider>().measurement == null
                      ? "염도 정보 없음"
                      : "염분도:${context.watch<PositionProvider>().measurement!.salinity.roundToDouble()}psu",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "측정 위치:${context.watch<PositionProvider>().position.name}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  context.watch<PositionProvider>().measurement == null
                      ? "측정 시간 없음"
                      : "측정 시간:${context.watch<PositionProvider>().measurement!.date.toDate()}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: context.watch<AdMobProvider>().bannerAd != null
          ? SizedBox(
              width: context
                  .watch<AdMobProvider>()
                  .bannerAd!
                  .size
                  .width
                  .toDouble(),
              height: context
                  .watch<AdMobProvider>()
                  .bannerAd!
                  .size
                  .height
                  .toDouble(),
              child: AdWidget(ad: context.watch<AdMobProvider>().bannerAd!),
            )
          : null,
    );
  }
}
