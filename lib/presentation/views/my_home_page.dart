import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nakdong_river/domain/position.dart';

import 'package:nakdong_river/presentation/providers/position_provider.dart';
import 'package:nakdong_river/presentation/providers/admob_provider.dart';

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
            image: AssetImage('images/Nackdong.jpg'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: ListView(
          children: [
            Slider(
              value: context
                  .watch<PositionProvider>()
                  .currentSliderValue
                  .toDouble(),
              max: context.watch<PositionProvider>().depthsLength - 1,
              divisions: context.watch<PositionProvider>().depthsLength,
              label: context.watch<PositionProvider>().currnetDepthLabel,
              onChanged: (double value) {
                context.read<PositionProvider>().setCurrentSliderValue(value);
              },
            ),
            Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                Text(
                  "${context.watch<PositionProvider>().measurements.temperature}°C",
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
                  "염분도:${context.watch<PositionProvider>().measurements.salinity}psu",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "측정 위치:${context.watch<PositionProvider>().measurements.position.name}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "측정 시간:${context.watch<PositionProvider>().measurements.time.toDate()}",
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
