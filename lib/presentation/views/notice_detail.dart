import 'package:flutter/material.dart';
import 'package:nakdong_river/domain/notice.dart';

class NoticeDetailPage extends StatelessWidget {
  const NoticeDetailPage({super.key, required this.notice});

  final Notice notice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("공지사항"),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text(notice.title, style: const TextStyle(fontSize: 20)),
            ),
            ListTile(
              title: Text(notice.content.replaceAll("\\n", "\n")),
              subtitle: Text(notice.createdAt.toDate().toString()),
            ),
          ],
        ));
  }
}
