import 'package:flutter/material.dart';
import 'package:manga_app/components/manga_list/index.dart';
import 'package:manga_app/util/api.dart';
import 'package:manga_app/util/attributes.dart';
import 'package:web_scraper/web_scraper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController selectPageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int selectedPageIndex = 1;
  bool mangaLoaded = false;
  List<Map<String, dynamic>>? mangaList;
  List<Map<String, dynamic>>? mangaUrlList;
  List<String?>? mangaPoint;
  List<Map<String, dynamic>>? mangaStars;
  void setPageIndex(int index) {
    setState(() {
      if (selectedPageIndex + index >= 1)
        selectedPageIndex = selectedPageIndex + index;
    });
  }

  void selectPageIndex(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void fetchManga() async {
    final webscraper = WebScraper(Api.baseUrl);
    if (await webscraper.loadWebPage(selectedPageIndex == 1
        ? "manga-list/"
        : "manga-list/page/${selectedPageIndex}/")) {
      mangaList = webscraper.getElement(
        Attributes.mangaList,
        ['src', 'title'],
      );
      mangaUrlList = webscraper.getElement(
        Attributes.mangaUrlList,
        ['href'],
      );
      mangaPoint = webscraper.getElementAttribute(
          Attributes.mangaPoint, "data-current-rating");

      setState(() {
        mangaLoaded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchManga();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Manga reader"),
          backgroundColor: Colors.greenAccent[700],
        ),
        body: Stack(
          children: [
            mangaLoaded
                ? MangaList(
                    mangaList: mangaList,
                    mangaUrlList: mangaUrlList,
                    mangaPoint: mangaPoint,
                  )
                : Align(
                    //alignment: Alignment.centerRight,
                    child: CircularProgressIndicator()),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.greenAccent[700],
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        selectedPageIndex - 1 > 0
                            ? "Page ${selectedPageIndex - 1}"
                            : "Page $selectedPageIndex",
                        style: TextStyle(
                            color: selectedPageIndex - 1 > 0
                                ? Colors.white
                                : Colors.white54,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          selectedPageIndex - 1 > 0
                              ? showBackBuntton()
                              : unShowBackBuntton(),
                          SizedBox(
                            width: 25,
                          ),
                          InkWell(
                            onTap: () {
                              _showMaterialDialog();
                            },
                            child: Container(
                              color: Colors.black45,
                              width: 30,
                              child: Text(
                                "$selectedPageIndex",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          selectedPageIndex + 1 <= 30
                              ? showNextButton()
                              : unShowNextButton()
                        ],
                      ),
                      Text(
                        selectedPageIndex + 1 <= 30
                            ? "Page ${selectedPageIndex + 1}"
                            : "Page $selectedPageIndex",
                        style: TextStyle(
                            color: selectedPageIndex + 1 <= 30
                                ? Colors.white
                                : Colors.white54,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget showBackBuntton() {
    return InkWell(
      onTap: () {
        setPageIndex(-1);
        setState(() {
          mangaLoaded = false;
        });
        fetchManga();
      },
      child: Row(
        children: [
          Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          Text(
            "Back",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget unShowBackBuntton() {
    return Row(
      children: [
        Icon(
          Icons.arrow_back_ios,
          color: Colors.white54,
        ),
        Text(
          "Back",
          style: TextStyle(
              color: Colors.white54, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget showNextButton() {
    return InkWell(
      onTap: () {
        setPageIndex(1);
        setState(() {
          mangaLoaded = false;
        });
        fetchManga();
      },
      child: Row(
        children: [
          Text(
            "Next",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget unShowNextButton() {
    return Row(
      children: [
        Text(
          "Next",
          style: TextStyle(
              color: Colors.white54, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Colors.white54,
        ),
      ],
    );
  }

  void _showMaterialDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Select Page",
            style: TextStyle(color: Colors.greenAccent[700]),
          ),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: selectPageController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  if (int.parse(value) > 30) {
                    return 'Manga reader has limit 30 pages';
                  } else if (int.parse(value) <= 0) {
                    return 'Manga reader page start at page 1';
                  }
                } else {
                  return 'Please enter pages';
                }
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancle',
                  style: TextStyle(color: Colors.redAccent)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.greenAccent[700]),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  selectPageIndex(int.parse(selectPageController.text));
                  setState(() {
                    mangaLoaded = false;
                    selectPageController.text = "";
                  });
                  fetchManga();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
