import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nakdong_river/http.dart';
import 'package:nakdong_river/model.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nakdong_river/widget.dart';

String teststring = "";
//debug
String selectedlocaion = '2022B2a';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
      appBar: AppBar(
        title: const Text("낙동"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          PopupMenuButton(
            onSelected: ((value) {
              setState(() {
                selectedlocaion = value.toString();
                queryParameters['wtqltObsrvtCd'] = value.toString();
              });
              setState(() {
                myFuture = getTemp();
              });
            }),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: '2022B4a',
                child: Text('하구둑8번교각'),
              ),
              const PopupMenuItem(
                value: '2022B4b',
                child: Text('하구둑10번교각'),
              ),
              const PopupMenuItem(
                value: '2022B4c',
                child: Text('갑문상류'),
              ),
              const PopupMenuItem(
                value: '2022B5a',
                child: Text('을숙도대교P3'),
              ),
              const PopupMenuItem(
                value: '2022B5b',
                child: Text('을숙도대교P20'),
              ),
              const PopupMenuItem(
                value: '2022B1a',
                child: Text('낙동강 하구둑'),
              ),
              const PopupMenuItem(
                value: '2022B2a',
                child: Text('낙동대교'),
              ),
              const PopupMenuItem(
                value: '2022B3a',
                child: Text('우안배수문'),
              ),
              // Now not work API
              // const PopupMenuItem(
              //   value: '2022A1a',
              //   child: Text('낙동강상류3km'),
              // ),
              // const PopupMenuItem(
              //   value: '2022A1b',
              //   child: Text('낙동강상류7.5km'),
              // ),
              // const PopupMenuItem(
              //   value: '2022A2b',
              //   child: Text('낙동강상류9km'),
              // ),
              // const PopupMenuItem(
              //   value: '2022A2a',
              //   child: Text('낙동강상류10km'),
              // ),
            ],
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
              future: myFuture,
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
            // IconButton(
            //   onPressed: () {
            //     setState(() {
            //       myFuture = getTemp();
            //       getTemp();
            //     });
            //   },
            //   icon: const Icon(
            //     Icons.refresh_outlined,
            //     color: Colors.white,
            //   ),
            // ),
            // Text(
            //   teststring,
            //   style: const TextStyle(color: Colors.white),
            // ),
            // Text(
            //   getToday(),
            //   style: const TextStyle(
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Text(
            //   beforeTime(),
            //   style: const TextStyle(
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Text(
            //   afterTime(),
            //   style: const TextStyle(
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Text(
            //   selectedlocaion,
            //   style: const TextStyle(
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
