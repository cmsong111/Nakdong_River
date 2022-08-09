import 'package:flutter/material.dart';
import 'package:nakdong_river/http.dart';
import 'package:nakdong_river/model.dart';

String teststring = "";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Temp> myFuture = getTemp();

  @override
  void initState() {
    super.initState();
    myFuture = getTemp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Nackdong.jpeg'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: ListView(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    myFuture = getTemp();
                  });
                },
                icon: Icon(Icons.refresh_outlined)),
            Text(
              teststring,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              getToday(),
            ),
            Text(
              beforeTime(),
            ),
            Text(
              afterTime(),
            ),
            FutureBuilder<Temp>(
              future: myFuture,
              builder: ((context, snapshot) {
                if (snapshot.hasData == false) {
                  return const CircularProgressIndicator();
                } else {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 100,
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
                        margin: EdgeInsets.all(10),
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
                        "측정 시간:${snapshot.data!.response!.body!.items!.item!.msmtTm}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "측정 시간:${snapshot.data!.response?.body?.items?.item?.msmtTm}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
