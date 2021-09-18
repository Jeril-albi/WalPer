import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallper/data/data.dart';
import 'package:wallper/data/jeril.dart';
import 'package:wallper/data/purchase.dart';
import 'package:wallper/model/categories.dart';
import 'package:wallper/model/wallpaper.dart';
import 'package:wallper/views/explore.dart';
import 'package:wallper/views/premium.dart';
import 'package:wallper/views/category.dart';
import 'package:wallper/views/search.dart';
import 'package:wallper/widget/widget.dart';
import 'package:http/http.dart' as http;
import 'ads.dart';

class Home extends StatefulWidget {
  @override
  _home createState() => _home();
}

class _home extends State<Home> {
  Ads advert = Ads();
  DateTime exitPress;
  DateTime now = DateTime.now();
  String about = 'about';
  String contact = 'contact us';
  List<Categoriesmodel> catagories = new List();
  List<Wallpapermodel> wallpapers = new List();

  TextEditingController searchController = new TextEditingController();

  trendingWallpapers() async {
    var response = await http.get(
        'https://api.pexels.com/v1/search?query=mobile wallpapers&per_page=$page&page=${now.day}',
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

  bool internet;

  connection(BuildContext context) async {
    var connection = await Connectivity().checkConnectivity();
    if (connection == ConnectivityResult.none) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("No Internet"),
              content: Text("Please check your internet connection"),
              actions: <Widget>[
                TextButton(
                  child: Text("Try Again"),
                  onPressed: () {
                    Connectivity().onConnectivityChanged.listen((event) {});
                  },
                ),
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text("Exit"),
                ),
              ],
            );
          });
    } else {
      return internet = false;
    }
  }

  @override
  void initState() {
    PurchaseApi.updatePurchaseStatus();
    catagories = getCatagories();
    isPurchased ? null : Ads.mybanner.load();
    connection(context);
    trendingWallpapers();
    super.initState();
  }

  @override
  void dispose() {
    isPurchased ? null : Ads.mybanner?.dispose();
    isPurchased ? null : advert.closeInter();
    super.dispose();
  }

  Future<bool> onBackPress() {
    DateTime now = DateTime.now();
    if (exitPress == null || now.difference(exitPress) > Duration(seconds: 2)) {
      exitPress = now;
      Fluttertoast.showToast(msg: 'Press again to exit');
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: isPurchased ? premiumtitle() : brandName(),
        elevation: 0,
      ),
      body: WillPopScope(
        onWillPop: onBackPress,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
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
                                if (searchController.text.toLowerCase() ==
                                    about) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Jeril()));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Search(
                                                searchQuery:
                                                    searchController.text,
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
                    new SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 80,
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        itemCount: catagories.length,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Categorietile(
                            title: catagories[index].categoriesname,
                            imgurl: catagories[index].imgurl,
                          );
                        },
                      ),
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
      ),
    );
  }
}

class Categorietile extends StatelessWidget {
  String imgurl, title;
  Categorietile({@required this.imgurl, @required this.title});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(right: 4),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            child: Image.network(
              imgurl,
              width: 100,
              height: 50,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          GestureDetector(
            onTap: () {
              if (title == 'Premium') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Premium()));
              } else if (title == 'Explore') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Explore()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Category(
                              categoriesName: title.toLowerCase(),
                            )));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
