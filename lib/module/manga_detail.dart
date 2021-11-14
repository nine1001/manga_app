import 'package:flutter/material.dart';
import 'package:manga_app/components/manga_chapter/index.dart';
import 'package:manga_app/components/manga_genaral/index.dart';
import 'package:manga_app/components/manga_detail_info/index.dart';
import 'package:manga_app/util/api.dart';
import 'package:manga_app/util/attributes.dart';
import 'package:web_scraper/web_scraper.dart';

class MangaDetail extends StatefulWidget {
  final String? mangaImg, mangaTitle, mangaLink;
  final String? mangaPoint;
  const MangaDetail(
      {Key? key,
      this.mangaImg,
      this.mangaTitle,
      this.mangaLink,
      this.mangaPoint})
      : super(key: key);

  @override
  _MangaDetailState createState() => _MangaDetailState();
}

class _MangaDetailState extends State<MangaDetail> {
  String? mangaGenres,
      mangaAuthor,
      mangaDesc,
      mangaStatus,
      mangaType,
      mangaYear,
      totalBooks,
      alternative;
  List<Map<String, dynamic>>? mangaDetail;
  List<Map<String, dynamic>>? mangaDescList;
  List<Map<String, dynamic>>? mangaChapters;

  bool dataFetch = false;

  void getMangaInfos() async {
    String tempRoute = widget.mangaLink!.split(".com")[1];

    final webscraper = WebScraper(Api.baseUrl);

    if (await webscraper.loadWebPage(tempRoute)) {
      mangaDetail = webscraper.getElement(
        Attributes.mangaDetail,
        [],
      );
      mangaDescList = webscraper.getElement(
        Attributes.mangaDescList,
        [],
      );
      mangaChapters = webscraper.getElement(Attributes.mangaChapters, ["href"]);
    }

    mangaGenres = mangaDetail![0]['title'].toString().trim();
    mangaAuthor = findTitle(mangaDetail, "ผู้เขียน");
    mangaStatus = findTitle(mangaDetail, "สถานะ");
    mangaType = findTitle(mangaDetail, "ประเภท");
    mangaYear = findTitle(mangaDetail, "ปี");
    totalBooks = findTitle(mangaDetail, "จำนวนเล่มทั้งหมด");
    mangaDesc = mangaDescList![0]['title'].toString().trim();
    alternative = findTitle(mangaDetail, "Alternative");

    setState(() {
      dataFetch = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getMangaInfos();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("รายละเอียด"),
        centerTitle: true,
        backgroundColor: Colors.redAccent[700],
      ),
      body: dataFetch
          ? SafeArea(
              child: Container(
                height: screenSize.height,
                width: screenSize.width,
                color: Colors.red[300],
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        widget.mangaTitle!,
                        style: TextStyle(fontSize: 24, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MangaDetailInfo(
                        mangaImg: widget.mangaImg,
                        mangaAuthor: mangaAuthor,
                        mangaDesc: mangaDesc!,
                      ),
                      Container(
                        width: double.infinity,
                        height: 10,
                        color: Colors.black,
                      ),
                      MangaGenaral(
                        mangaGenres: mangaGenres!,
                        mangaStatus: mangaStatus,
                        mangaType: mangaType,
                        mangaYear: mangaYear,
                        totalBooks: totalBooks,
                        alternative: alternative,
                      ),
                      Container(
                        width: double.infinity,
                        height: 10,
                        color: Colors.black,
                      ),
                      MangaChapters(
                        mangaChapters: mangaChapters!,
                      )
                    ],
                  ),
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  findTitle(List<Map<String, dynamic>>? mangaDetail, String title) {
    var found = mangaDetail!
        .where((element) => element['title'].toString().contains(title));
    if (found.isNotEmpty) {
      return found.elementAt(0)['title'];
    } else {
      return "";
    }
  }
}
