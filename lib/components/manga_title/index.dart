import 'package:flutter/material.dart';
import 'package:manga_app/module/manga_detail.dart';
import 'package:manga_app/util/api.dart';

class MangaTitle extends StatelessWidget {
  final String? mangaImg, mangaTitle, mangaUrlList, mangaPoint;

  const MangaTitle(
      {Key? key,
      this.mangaImg,
      this.mangaTitle,
      this.mangaUrlList,
      this.mangaPoint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 135,
        child: InkWell(
          onTap: () {
            // print(mangaUrlList);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MangaDetail(
                  mangaImg: mangaImg,
                  mangaLink: mangaUrlList,
                  mangaTitle: mangaTitle,
                  mangaPoint: convertPoint(mangaPoint!),
                ),
              ),
            );
          },
          child: Container(
            color: Colors.lightGreenAccent,
            child: Row(children: [
              Container(
                height: 135,
                width: 135,
                child: Image.network(
                  mangaImg!,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        child: Expanded(
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Title : $mangaTitle",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Point : ${convertPoint(mangaPoint!)}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "/10",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Stars :",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          for (int i = 0;
                              i < convertPointToInt(mangaPoint!);
                              i++)
                            Icon(
                              Icons.star,
                              color: Colors.redAccent[400],
                            ),
                          for (int i = 0;
                              i < (5 - convertPointToInt(mangaPoint!));
                              i++)
                            Icon(Icons.star_border_outlined),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    ]);
  }

  int convertPointToInt(String point) {
    double p = double.parse(point);
    int x = p.toInt();
    return x;
  }

  String convertPoint(String point) {
    double deci2 = (double.parse(point) * 2);
    return deci2.toStringAsFixed(2);
  }
}
