import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:manga_app/util/api.dart';
import 'package:manga_app/util/attributes.dart';
import 'package:web_scraper/web_scraper.dart';

class ChapterScreen extends StatefulWidget {
  final String routePath;
  ChapterScreen({Key? key, required this.routePath}) : super(key: key);

  @override
  _ChapterScreenState createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  List<Map<String, dynamic>>? chapterPage;
  bool dataFetcged = false;
  bool hideBackButton = false;
  void getChapter() async {
    final scraper = WebScraper(Api.baseUrl);
    String route = widget.routePath;
    if (await scraper.loadWebPage(route)) {
      chapterPage = scraper.getElement(Attributes.chapterPage, ['src']);

      setState(() {
        dataFetcged = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getChapter();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: dataFetcged
            ? NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  if (notification.direction == ScrollDirection.forward) {
                    if (!hideBackButton) {
                      setState(() {
                        hideBackButton = true;
                      });
                    }
                  } else if (notification.direction ==
                      ScrollDirection.reverse) {
                    if (hideBackButton) {
                      setState(() {
                        hideBackButton = false;
                      });
                    }
                  }
                  return true;
                },
                child: Container(
                  child: ListView.builder(
                      itemCount: chapterPage!.length,
                      itemBuilder: (context, index) {
                        print(chapterPage![index]['attributes']['src']
                            .toString()
                            .trim());
                        return FadeInImage(
                          image: NetworkImage(
                              chapterPage![index]['attributes']['src']),
                          placeholder:
                              AssetImage("assets/images/image_loading.gif"),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/images/image_error.png',
                                fit: BoxFit.fitWidth);
                          },
                          fit: BoxFit.fitWidth,
                        );
                      }),
                ),
              )
            : Center(child: CircularProgressIndicator()),
        floatingActionButton: Visibility(
          visible: hideBackButton,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Back",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            backgroundColor: Colors.lightGreenAccent[700],
          ),
        ),
      ),
    );
  }
}
