import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nakdong_river/presentation/views/oss_licenses_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("images/AppIcon.png", width: 50),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      '낙동 - 낙동강 수온체크',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 45,
                ),
                const Text(
                  "Copyright 2022. Namju all rights reserved.",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('문의하기'),
            onTap: () {
              _sendEmail();
            },
          ),
          ListTile(
            title: const Text('Open source license'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const OssLicensesPage();
              }));
            },
          ),
        ],
      ),
    );
  }
}

void _sendEmail() async {
  final Email email = Email(
    body: '',
    subject: '[낙동 문의하기]',
    recipients: ['cmsong111@gmail.com'],
    cc: [],
    bcc: [],
    attachmentPaths: [],
    isHTML: false,
  );

  try {
    await FlutterEmailSender.send(email);
  } catch (error) {
    String title = "Error\ncmsong111@gmail.com 아래로 문의주세요";
    Fluttertoast.showToast(msg: title);
  }
}
