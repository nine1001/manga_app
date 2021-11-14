import 'package:flutter/material.dart';

class MangaGenaral extends StatefulWidget {
  final String? mangaGenres,
      mangaStatus,
      mangaType,
      mangaYear,
      totalBooks,
      alternative;

  const MangaGenaral({
    Key? key,
    this.mangaGenres,
    this.mangaStatus,
    this.mangaType,
    this.mangaYear,
    this.totalBooks,
    this.alternative,
  }) : super(key: key);

  @override
  _MangaGenaralState createState() => _MangaGenaralState();
}

class _MangaGenaralState extends State<MangaGenaral> {
  bool readMore = false;

  void toggleRead() {
    setState(() {
      readMore = !readMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "ข้อมูลทั่วไป",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.mangaType!.trim() == "ประเภท"
                      ? "${widget.mangaType} -"
                      : "${widget.mangaType}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  widget.mangaStatus!.trim() == "สถานะ"
                      ? "${widget.mangaStatus} -"
                      : "${widget.mangaStatus}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.mangaYear!.trim() == "ปี"
                      ? "${widget.mangaYear} -"
                      : "${widget.mangaYear}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  widget.totalBooks!.trim() == "จำนวนเล่มทั้งหมด"
                      ? "${widget.totalBooks} -"
                      : "${widget.totalBooks} เล่ม",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.alternative!.isEmpty
                  ? "Alternative  -"
                  : "${widget.alternative}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
