import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallper/data/data.dart';
import 'package:wallper/model/wallpaper.dart';
import 'package:wallper/views/premium.dart';
import 'package:wallper/widget/widget.dart';
import 'package:wallper/views/ads.dart';
import 'package:flutter/services.dart';

class Category extends StatefulWidget {
  final String categoriesName;
  Category({this.categoriesName});

  @override
  _category createState() => _category();
}

class _category extends State<Category> {
  Ads advert = Ads();
  DateTime now = DateTime.now();
  List<Wallpapermodel> wallpapers = new List();

  searchWallpapers(String query) async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=$page&page=${now.day}",
        headers: {
          "Authorization": apikey,
        });

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      Wallpapermodel wallpapermodel = new Wallpapermodel();
      wallpapermodel = Wallpapermodel.fromMap(element);
      wallpapers.add(wallpapermodel);
    });

    setState(() {});
  }

  @override
  void initState() {
    searchWallpapers(widget.categoriesName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: isPurchased ? premiumtitle() : brandName(),
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 16,
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
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black)),
                              child: Text(
                                "  Upgrade to King version for more wallpapers  ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          isPurchased
              ? SizedBox(
                  height: 1,
                )
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: advert.showBanner(),
                ),
        ],
      ),
    );
  }
}
