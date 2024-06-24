import 'package:cloud_firestore/cloud_firestore.dart';

class Notice {
  final String title;
  final String content;
  final Timestamp createdAt;

  Notice({
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory Notice.fromMap(Map<String, dynamic> map) {
    print(map);
    var notice = Notice(
      title: map['title'],
      content: map['content'],
      createdAt: map['createdAt'],
    );
    print(notice);
    return notice;
  }
}
