import 'package:flutter/material.dart';
import 'package:manga_app/components/manga_title/index.dart';
import 'package:manga_app/util/api.dart';

class MangaList extends StatelessWidget {
  final List<Map<String, dynamic>>? mangaList;
  final List<Map<String, dynamic>>? mangaUrlList;
  final List<String?>? mangaPoint;

  const MangaList(
      {Key? key, this.mangaList, this.mangaUrlList, this.mangaPoint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height - 130,
      color: Colors.white54,
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < mangaList!.length; i++)
              Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  MangaTitle(
                    mangaImg: mangaList![i]['attributes']['src'],
                    mangaTitle: mangaList![i]['attributes']['title'],
                    mangaUrlList: mangaUrlList![i]['attributes']['href'],
                    mangaPoint: mangaPoint![i],
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
