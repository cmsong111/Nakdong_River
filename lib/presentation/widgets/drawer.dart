import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nakdong_river/presentation/providers/package_info_provider.dart';
import 'package:nakdong_river/presentation/views/notice_list.dart';
import 'package:nakdong_river/presentation/views/oss_licenses_page.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              // primary Color
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("images/AppIcon.png", width: 50),
                    const Text(
                      ' 낙동강 수온체크',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "Copyright ⓒ 2022-2024 낙동",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Version ${Provider.of<PackageInfoProvider>(context).packageInfo?.version}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('공지사항'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const NoticeListPage();
              }));
            },
          ),
          ListTile(
            title: const Text('문의하기'),
            onTap: () {
              _sendEmail();
            },
          ),
          ListTile(
            title: const Text('오픈소스 라이센스'),
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
