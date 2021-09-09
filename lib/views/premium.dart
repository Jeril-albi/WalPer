import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:wallper/data/purchase.dart';
import 'package:wallper/model/wallpaper.dart';
import 'package:http/http.dart' as http;
import 'package:wallper/data/data.dart';
import 'package:wallper/views/ads.dart';
import 'package:wallper/widget/widget.dart';

//cloud_firestore: ^^0.14.1+3
//firebase_core: ^0.5.0+1

final String productID = 'walper_weekly';

class Premium extends StatefulWidget {
  @override
  _premium createState() => _premium();
}

class _premium extends State<Premium> {
  Ads advert = Ads();
  List<Wallpapermodel> wallpapers = new List();
  var iap;

  Future fetchOffers() async {
    final offerings = await PurchaseApi.fetchOffers();

    if (offerings.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("No plans available now"),
      ));
    } else {
      final packages = offerings
          .map((offer) => offer.availablePackages)
          .expand((pair) => pair)
          .toList();
      setState(() {
        iap = packages;
      });
    }
  }

  kingVersion(BuildContext context) {
    Package package1 = iap[0];
    Package package2 = iap[1];
    Package package3 = iap[2];
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              height: MediaQuery.of(context).size.height * .55,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Text(
                      "King Version",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ]),
                  SizedBox(
                    height: 25,
                  ),
                  isPurchased
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'King Version Unlocked',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900),
                            ),
                            Text(
                                '( If changes may not happen please reopen the app )')
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "1 Week",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await PurchaseApi.purchasePackage(
                                              iap[0]);
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: Colors.redAccent[100],
                                          ),
                                          height: 50,
                                          width: 100,
                                          child: Center(
                                            child: Text(
                                              "${package1.product.price} ${package1.product.currencyCode}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "1 Month",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await PurchaseApi.purchasePackage(
                                              iap[1]);
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: Colors.yellowAccent[100],
                                          ),
                                          height: 50,
                                          width: 100,
                                          child: Center(
                                            child: Text(
                                              "${package2.product.price} ${package2.product.currencyCode}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "1 Year",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await PurchaseApi.purchasePackage(
                                              iap[2]);
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: Colors.greenAccent[100],
                                          ),
                                          height: 50,
                                          width: 100,
                                          child: Center(
                                            child: Text(
                                              "${package3.product.price} ${package3.product.currencyCode}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${package1.product.description}',
                              style: TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                ]),
              ),
            );
          });
        });
  }

  @override
  void initState() {
    PurchaseApi.updatePurchaseStatus();
    searchWallpapers();
    fetchOffers();
    super.initState();
    isPurchased ? null : Ads.mybanner.dispose();
    isPurchased ? null : advert.loadReward();
  }

  @override
  void dispose() {
    isPurchased ? null : advert.closeReward();
    super.dispose();
  }

  searchWallpapers() async {
    DocumentSnapshot content = await FirebaseFirestore.instance
        .collection('premium')
        .doc('premiumcontent')
        .get();

    var response = await http.get(
        "https://api.pexels.com/v1/search?query=${content['content']}&per_page=$page&page=${content['page']}",
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
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: premiumCatgorytitle(),
        actions: [
          GestureDetector(
            onTap: () {
              kingVersion(context);
            },
            child: Container(
                height: 35,
                width: 35,
                child: Image.asset('assets/premium.gif')),
          ),
          SizedBox(
            width: 25,
          )
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Premiumlist(wallpapers, context),
              isPurchased
                  ? SizedBox(
                      height: 1,
                    )
                  : InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => kingVersion(context)));
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
    );
  }
}
