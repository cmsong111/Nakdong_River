import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nakdong_river/oss_licenses.dart';

class MyOss extends StatelessWidget {
  const MyOss({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Open source license")),
      body: ListView.builder(
        itemCount: ossLicenses.length,
        itemBuilder: ((context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Get.to(
                  OssDetial(),
                  arguments: index,
                );
              },
              title: Text(ossLicenses[index].name),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        }),
      ),
    );
  }
}

class OssDetial extends StatelessWidget {
  OssDetial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ossLicenses[Get.arguments].name),
      ),
      body: ListView(
        children: [
          Text("name: ${ossLicenses[Get.arguments].name}"),
          Text("description ${ossLicenses[Get.arguments].description}"),
          Text("repository: ${ossLicenses[Get.arguments].repository}"),
          Text("authors:${ossLicenses[Get.arguments].authors}"),
          Text("version ${ossLicenses[Get.arguments].version}"),
          Text("license${ossLicenses[Get.arguments].license}"),
        ],
      ),
    );
  }
}
