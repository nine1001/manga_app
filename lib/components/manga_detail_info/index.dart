import 'package:flutter/material.dart';

class MangaDetailInfo extends StatelessWidget {
  final String? mangaImg, mangaAuthor, mangaDesc;

  const MangaDetailInfo(
      {Key? key, this.mangaImg, this.mangaAuthor, this.mangaDesc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: 160,
                    width: 130,
                    child: Image.network(
                      mangaImg!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    mangaAuthor!.trim() == "ผู้เขียน"
                        ? "$mangaAuthor Unknow"
                        : "$mangaAuthor",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "เรื่องย่อ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 150,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: SingleChildScrollView(
                      child: Text(
                        mangaDesc!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                        maxLines: 100,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
