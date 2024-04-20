import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nakdong_river/domain/position.dart';

import 'package:nakdong_river/model.dart';

import 'package:nakdong_river/presentation/widgets/drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Temp> getTemp(BuildContext context) async {
    String data =
        await DefaultAssetBundle.of(context).loadString('json/response.json');
    var jsonResult = jsonDecode(data);
    Temp temp = Temp.fromJson(jsonResult);
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("낙동"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          PopupMenuButton(
            onSelected: ((value) {}),
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
            FutureBuilder<Temp>(
              future: getTemp(context),
              builder: ((context, snapshot) {
                if (snapshot.hasData == false) {
                  return const CircularProgressIndicator();
                } else {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 150,
                      ),
                      Text(
                        "${snapshot.data!.response!.body!.items!.item!.wtep}°C",
                        style: const TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        height: 1,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                      ),
                      Text(
                        "염분도:${snapshot.data!.response!.body!.items!.item!.saln}psu",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "측정 위치:${snapshot.data!.response!.body!.items!.item!.obsrvtNm}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "측정 시간:${snapshot.data!.response!.body!.items!.item!.msmtTm.toString().substring(4, 6)}월 ${snapshot.data!.response!.body!.items!.item!.msmtTm.toString().substring(6, 8)}일 ${snapshot.data!.response!.body!.items!.item!.msmtTm.toString().substring(8, 10)}시 ${snapshot.data!.response!.body!.items!.item!.msmtTm.toString().substring(10, 12)}분",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
