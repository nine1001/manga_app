import 'package:flutter/material.dart';
import 'package:manga_app/module/chapter_screen.dart';
import 'package:manga_app/util/api.dart';

class MangaChapters extends StatelessWidget {
  final List<Map<String, dynamic>>? mangaChapters;

  const MangaChapters({Key? key, this.mangaChapters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, top: 5),
            child: Text(
              "จำนวนตอนทั้งหมด",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: mangaChapters!.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  height: 50,
                  padding: EdgeInsets.only(bottom: 4),
                  width: double.infinity,
                  child: Material(
                    color: Colors.black45,
                    child: InkWell(
                      onTap: () {
                        var splitPath = mangaChapters![index]['attributes']
                                ['href']
                            .toString()
                            .split(".com/");

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChapterScreen(
                              routePath: splitPath[1],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            mangaChapters![index]['title'],
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ]);
  }
}
