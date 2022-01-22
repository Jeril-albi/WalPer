import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unity_ads_plugin/unity_ads.dart';
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
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

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
                    Connectivity().onConnectivityChanged.listen((event) {
                      Navigator.pop(context);
                    });
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
    connection(context);
    trendingWallpapers();
    advert.initialize();
    super.initState();
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

  menuDrawer() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * .6,
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            "Categories",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent[700]),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * .6,
            height: MediaQuery.of(context).size.height * .92,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 24),
              itemCount: catagories.length,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Categorietile(
                  title: catagories[index].categoriesname,
                  imgurl: catagories[index].imgurl,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    SystemChrome.setEnabledSystemUIOverlays([]);
    return new Scaffold(
      backgroundColor: Colors.white,
      drawer: menuDrawer(),
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      body: WillPopScope(
        onWillPop: onBackPress,
        child: Stack(
          children: [
            Container(
              width: mediaquery.width,
              height: mediaquery.height * .4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/home.jpg"), fit: BoxFit.cover)),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: mediaquery.width,
                    height: mediaquery.height * .06,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: mediaquery.width * .05,
                        ),
                        GestureDetector(
                          onTap: () {
                            scaffoldKey.currentState.openDrawer();
                          },
                          child: Container(
                            width: 40,
                            height: mediaquery.height * .04,
                            decoration: BoxDecoration(
                                color: Colors.redAccent[700],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(blurRadius: 5, color: Colors.white)
                                ]),
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: mediaquery.width * .25,
                        ),
                        isPurchased
                            ? newPremiumTitle(MainAxisAlignment.start)
                            : newTitle(MainAxisAlignment.start)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: mediaquery.height * .1,
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
                ],
              ),
            ),
            Container(
              width: mediaquery.width,
              margin: EdgeInsets.only(top: mediaquery.height * .37),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  Container(
                    width: mediaquery.width,
                    height: mediaquery.height * .06,
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Trending",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          new SizedBox(
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
                ],
              ),
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
      margin: EdgeInsets.only(bottom: 10),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            child: Image.network(
              imgurl,
              width: 200,
              height: 100,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          GestureDetector(
            onTap: () {
              if (title == 'Premium') {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Premium()));
              } else if (title == 'Explore') {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Explore()));
              } else {
                Navigator.pop(context);
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
              height: 100,
              width: 200,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
