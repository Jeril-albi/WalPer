import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:image_downloader/image_downloader.dart';

class Exploreview extends StatefulWidget{

  final dynamic imgurl,imglink;
  Exploreview({@required this.imgurl,@required this.imglink});

  @override
  _Exploreview createState() => _Exploreview();
}

class _Exploreview extends State<Exploreview>{

  String _platformversion;
  String _wallpaperfile;

  @override
  void initState(){
    super.initState();
  }

  Future<void> initPlatformState() async{
    String platformversion;
    try{
      platformversion = await WallpaperManager.platformVersion;
    }on PlatformException{
      platformversion = 'Failed to get platform version. ';
    }

    if(!mounted) return;

    setState(() {
      _platformversion = platformversion;
    });
  }

  Future<void> home_wallpaper() async{
    setState(() {
      _wallpaperfile = 'Loading';
    });
    String result;
    var file = await DefaultCacheManager().getSingleFile(widget.imgurl);

    try{
      result = await WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.HOME_SCREEN );
    }on PlatformException{
      result = 'Failed to get wallpaper.';
    }

    if(!mounted) return;
    setState(() {
      _wallpaperfile = result;
    });
  }

  Future<void> lock_wallpaper() async{
    setState(() {
      _wallpaperfile = 'Loading';
    });
    String result;
    var file = await DefaultCacheManager().getSingleFile(widget.imgurl);

    try{
      result = await WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.LOCK_SCREEN );
    }on PlatformException{
      result = 'Failed to get wallpaper.';
    }

    if(!mounted) return;
    setState(() {
      _wallpaperfile = result;
    });
  }

  Future<void> both_wallpaper() async{
    setState(() {
      _wallpaperfile = 'Loading';
    });
    String result;
    var file = await DefaultCacheManager().getSingleFile(widget.imgurl);

    try{
      result = await WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.BOTH_SCREENS );
    }on PlatformException{
      result = 'Failed to get wallpaper.';
    }

    if(!mounted) return;
    setState(() {
      _wallpaperfile = result;
    });
  }

  Future<void> launchlink() async{
    if(await canLaunch(widget.imglink)){
       final bool applaunchsuccess = await launch(
           widget.imglink,
         forceSafariVC: false,
         universalLinksOnly: true,
       );
       if(!applaunchsuccess){
         await launch(
           widget.imglink,
           forceSafariVC: true,
         );
       }
    }
  }

  ask (BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Do you want to download"),
        content: Text("The file will be downloaded in downloads "),
        actions: [
          TextButton( child: Text("Yes"), onPressed: (){
            download();
            toastMsg();
            Navigator.pop(context);
          }),
          TextButton( child: Text("No"), onPressed: (){Navigator.pop(context);},)
        ],
      );
    });
  }

  toastMsg(){
    return Fluttertoast.showToast(msg: 'Downloading');
  }
  Future<void> download() async{
    try{
      var imgid = await ImageDownloader.downloadImage(widget.imgurl,destination: AndroidDestinationType.directoryDownloads);
      if(imgid == null){
        return;
      }
    }on PlatformException catch (error){

    }

  }

  dialog(BuildContext context) async{
    bool versioncheck;
    var androidinfo = await DeviceInfoPlugin().androidInfo;
    var sdkNo = androidinfo.version.sdkInt;
    if(sdkNo>=24){
      versioncheck = false;
    }else{
      versioncheck = true;
    }
    return showDialog(context: context, builder: (context){
      return AlertDialog(
          title: Text("Set Wallpaper"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.home),
                    TextButton(onPressed: versioncheck ? null : home_wallpaper,
                        child: Text("Home Screen")),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.screen_lock_portrait),
                    TextButton(onPressed: versioncheck ? null : lock_wallpaper,
                        child: Text(" Lock Screen")),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.phone_android),
                    TextButton(onPressed: both_wallpaper,
                        child: Text(" Both Screen")),
                  ],
                ),
              ],
            ),
          )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgurl,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(widget.imgurl,fit: BoxFit.cover,)
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height/4,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget> [
                InkWell(
                  onTap: (){Navigator.pop(context);},
                  child: new Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white54,width: 1),
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0x36393535),
                          Color(0x361D1B1B),
                        ],
                      ),
                    ),
                    child: Icon(Icons.arrow_back,color: Colors.white70,),
                  ),
                ),

                InkWell(
                  onTap: launchlink,
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width/4,
                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      color: Color(0xff1C1B1B),
                      border: Border.all(color: Colors.white54,width: 1),
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [
                          // Color(0x36FFFFFF),
                          Color(0x36393535),
                          Color(0x361D1B1B),
                        ],
                      ),
                    ),
                    child: Center(
                        child: Text(" Explore ",style: TextStyle(fontSize: 16,color: Colors.white70,fontWeight: FontWeight.w900),)
                    ),
                  ),
                ),

                InkWell(onTap: (){dialog(context);},
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width/4,
                    padding: EdgeInsets.symmetric(horizontal: 6,vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xff1C1B1B),
                      border: Border.all(color: Colors.white54,width: 1),
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [
                          Color(0x36393535),
                          Color(0x361D1B1B),
                        ],
                      ),
                    ),
                    child: Center(
                        child: Text("Wallpaper",style: TextStyle(fontSize: 16,color: Colors.white70,fontWeight: FontWeight.w900),)
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){ask(context);},
                  child: new Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white54,width: 1),
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0x36393535),
                          Color(0x361D1B1B),
                        ],
                      ),
                    ),
                    child: Icon(Icons.file_download,color: Colors.white70,),
                  ),
                )
              ],
            ),
          ),
          // SizedBox(
          //   height: 100,
          // ),

        ],
      ),
    );
  }
}
