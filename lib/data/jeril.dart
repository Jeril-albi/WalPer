import 'package:flutter/material.dart';

class Jeril extends StatefulWidget{
  @override
  _jeril createState() => _jeril();
}
class _jeril extends State<Jeril>{
 Widget title(){
   return Row(
     children: <Widget>[
       Text("Abo",style: TextStyle(color: Colors.black87),),
       Text("ut",style: TextStyle(color: Colors.redAccent[700]),),
     ],
   );
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        title: title(),
        ),
      body: Container(
        padding: EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("                WalPer is a wallpaper application made for android.This application was developed from Kerala,India with the intention of supporting Prime Minister Narendara Modi's Atma Nirbhar Movement.",style: TextStyle(fontSize: 15),),
              Text("                The images in this application are updated day by day.Most of the images are from pexels.We provide a list of categories to our users and each categories contain 80 images.You can also search your favourite wallpapers in the search bar.",style: TextStyle(fontSize: 15),),
              Text("                This app is a great tool for full hd Backgrounds and it is a wallpaper store for user where they can experience best handpicked hd wallpaper to make your screen unique and elegant.We add new unique as well as top quality wallpaper everyday. We think it’s important that you can easily find inspiring and beautiful wallpaper that will make you happy and feel great every time you pick up your phone.",style: TextStyle(fontSize: 15),),
              Text("                On average, nowadays, we check our phone over a hundred times a day. Our phone wallpaper being the first thing we see, it can really influence our mood and it is also a great way to express our unique personality.",style: TextStyle(fontSize: 15),),
              Text("                Our application is free, faster and offers the best collection of popular, free and high resolution featured wallpaper and backgrounds.",style: TextStyle(fontSize: 15),),
              Text("                This app is developed by Jeril Albi from Kerala,India.You can send your feedback and photographs in explore category.",style: TextStyle(fontSize: 15),),
              Text("                The advertisements in this app makes it an open source application.Enjoy our app and feel free to send feedback.",style: TextStyle(fontSize: 15),),
              Text(" "),
              Text(" "),
              Text(" "),
            ],
          ),
        ),
      )
    );
  }
}
/*
1qaz 2wsx 3edc 5tgb5tgb5tgb 5tgb5tgb 5tgb 5tgb
 */