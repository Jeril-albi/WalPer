import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallper/data/contact_us.dart';
import 'package:wallper/data/data.dart';
import 'package:wallper/views/ads.dart';
import 'package:wallper/views/explore_view.dart';
import 'package:flutter/services.dart';

class Explore extends StatefulWidget{
  @override
  _explore createState() => _explore();
}
class _explore extends State<Explore>{
Ads advert = Ads();
  Widget premiumtitle(){
    return Row(
      children: <Widget>[
        Text("Wal",style: TextStyle(color: Colors.black87),),
        Text("Per",style: TextStyle(color: Colors.redAccent[700]),),
        SizedBox(width: 5,),
        Container(
          height: 25,
          width: 25,
          child: Icon(Icons.explore_outlined,color: Colors.black87,)
        )
      ],
    );
  }

  @override
  void initState() {
    isPurchased ? null :  Ads.mybanner.dispose();
    super.initState();
  }

@override
void dispose(){
  isPurchased ? null : advert.closeInter();
  super.dispose();
}

Future<void> reviewApp() async{
  if(await canLaunch('https://www.amazon.com/dp/B097T2391B/ref=apps_sf_sta')){
    final bool applaunchsuccess = await launch(
      'https://play.google.com/store/apps/details?id=com.jerilalbi.wallper_pro',
      //'https://www.amazon.com/dp/B097T2391B/ref=apps_sf_sta',
      forceSafariVC: false,
      universalLinksOnly: true,
    );
    if(!applaunchsuccess){
      await launch(
        'https://play.google.com/store/apps/details?id=com.jerilalbi.wallper_pro',
       //'https://www.amazon.com/dp/B097T2391B/ref=apps_sf_sta',
        forceSafariVC: true,
      );
    }
  }
}
review(BuildContext context){
  return showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: Text("Review Now "),
      content: Text("Write your review and help us to improve"),
      actions: [
        TextButton(
            onPressed: (){reviewApp();},
            child: Text("Review Now")
        ),
        TextButton(
            onPressed: (){Navigator.pop(context);},
            child: Text("Later")
        )
      ],
    );
  });
}

  Query query = FirebaseFirestore.instance.collection('explore');

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    int load = 1;
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: premiumtitle(),
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Contact()
                ));
              },
              child: Container(
                  height: 25,
                  width: 25,
                  child: Icon(Icons.add_a_photo,color: Colors.redAccent[700],)
              ),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
              review(context);
              },
              child: Container(
                  height: 25,
                  width: 25,
                  child: Icon(Icons.star_rate_outlined,color: Colors.redAccent[700],)
              )
            ),
            SizedBox(
              width: 25,
            )
          ],
        ),
        body:  StreamBuilder<QuerySnapshot>(
            stream: query.snapshots(),
            builder: (context, stream) {
              if (stream.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (stream.hasError) {
                return Center(child: Text(stream.error.toString()),);
              }

              QuerySnapshot querySnapshot = stream.data;

              return GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                  ),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: querySnapshot.size,
                  itemBuilder: (context, index) {
                    DocumentSnapshot  img = querySnapshot.docs[index];

                    return  GridTile(
                      child: GestureDetector(
                        onTap: (){
                          if(isPurchased){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Exploreview(
                                  imgurl: img['src'],
                                  imglink: img['url'],
                                )
                            ));
                          } else{
                          if(load == 1){ advert.loadInter(); }
                          if(load == 5){
                            load = 0;
                            advert.showInter();
                          }
                          load = load + 1;
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Exploreview(
                                imgurl: img['src'],
                                imglink: img['url'],
                              )
                          ));
                          }
                        },
                        child: Hero(
                          tag:  img['src'],
                          child: Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child:  FadeInImage(
                                  image: NetworkImage(img['src']),
                                  fit: BoxFit.cover,
                                  placeholder: AssetImage("assets/loadimg.jpg"),
                                )
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              );
            }
        )
    );
  }
}
