import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nakdong_river/data/notice_repository_firebase.dart';
import 'package:nakdong_river/domain/notice.dart';
import 'package:nakdong_river/presentation/views/notice_detail.dart';

class NoticeListPage extends StatelessWidget {
  const NoticeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Notice>> data = NoticeRepositoryFirebase().getRecentData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('공지사항'),
      ),
      body: FutureBuilder<List<Notice>>(
        future: data,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(snapshot.data![index].title),
                      subtitle: Text(
                          snapshot.data![index].createdAt.toDate().toString()),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return NoticeDetailPage(
                                notice: snapshot.data![index] as Notice,
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
