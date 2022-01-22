import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallper/data/data.dart';
import 'package:wallper/data/jeril.dart';
import 'package:wallper/model/wallpaper.dart';
import 'package:wallper/views/premium.dart';
import 'package:wallper/widget/widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

import 'ads.dart';

class Search extends StatefulWidget {
  final String searchQuery;
  Search({this.searchQuery});

  @override
  _search createState() => _search();
}

class _search extends State<Search> {
  Ads advert = Ads();
  String query;
  bool searchLoaded = false;
  TextEditingController searchController = new TextEditingController();

  List<Wallpapermodel> wallpapers = new List();

  searchWallpapers(String query) async {
    var response = await http.get(
      "https://api.pexels.com/v1/search?query=$query&per_page=$page&page=1",
      headers: {
        "Authorization": apikey,
      },
    );

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      Wallpapermodel wallpapermodel = new Wallpapermodel();
      wallpapermodel = Wallpapermodel.fromMap(element);
      wallpapers.add(wallpapermodel);
    });
    searchLoaded = true;
    setState(() {});
  }

  @override
  void initState() {
    searchWallpapers(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    SystemChrome.setEnabledSystemUIOverlays([]);
    String about = 'about';
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: mediaQuery.width,
            height: mediaQuery.height * .4,
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: searchLoaded
                      ? NetworkImage("${wallpapers[0].src.landscape}")
                      : AssetImage(
                          "assets/search.jpg",
                        ),
                  fit: BoxFit.cover,
                )),
            child: Column(
              children: [
                SizedBox(height: 15),
                Container(
                  width: mediaQuery.width,
                  height: mediaQuery.height * .06,
                  child: newTitle(MainAxisAlignment.center),
                ),
                SizedBox(
                  height: mediaQuery.height * .1,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            if (searchController.text.toLowerCase() == about) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Jeril()));
                            } else {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => Search(
                                            searchQuery: searchController.text,
                                          )));
                            }
                          },
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Search Wallpapers",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        child: Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: mediaQuery.width,
            margin: EdgeInsets.only(top: mediaQuery.height * .37),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              children: [
                Container(
                  width: mediaQuery.width,
                  height: mediaQuery.height * .02,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Wallpaperlist(wallpapers, context),
                          isPurchased
                              ? SizedBox(
                                  height: 1,
                                )
                              : InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Premium()));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 150,
                                    width: MediaQuery.of(context).size.width,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Text(
                                        "  Upgrade to King version for more wallpapers  ",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
