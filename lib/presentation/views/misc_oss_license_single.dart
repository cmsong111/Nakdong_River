import 'package:flutter/material.dart';
import 'package:nakdong_river/oss_licenses.dart';

class MiscOssLicenseSingle extends StatelessWidget {
  final Package package;

  const MiscOssLicenseSingle({super.key, required this.package});

  String _bodyText() {
    return package.license!.split('\n').map((line) {
      if (line.startsWith('//')) line = line.substring(2);
      line = line.trim();
      return line;
    }).join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${package.name} ${package.version}')),
      body: Container(
          color: Theme.of(context).canvasColor,
          child: ListView(children: <Widget>[
            if (package.description.isNotEmpty)
              Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                  child: Text(package.description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold))),
            if (package.homepage != null)
              Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                  child: InkWell(
                    child: Text(package.homepage!,
                        style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline)),
                    // onTap: () => launch(package.homepage!),
                  )),
            if (package.description.isNotEmpty || package.homepage != null)
              const Divider(),
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
              child: Text(_bodyText(),
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
          ])),
    );
  }
}
