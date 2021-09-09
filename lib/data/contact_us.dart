
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget{
  @override
  _contact createState()=> _contact();
}

class _contact extends State<Contact>{

  Widget title(){
    return Row(
      children: <Widget>[
        Text("Send",style: TextStyle(color: Colors.black87),),
        Text(" To Us",style: TextStyle(color: Colors.redAccent[700]),),
      ],
    );
  }

  _launchurl(String mailId, String subject, String body) async{
   var url='mailto:$mailId?subject=$subject&body=$body';
   if(await canLaunch(url)){
     await launch(url);
   }else{
     throw 'could not launch $url';
   }
  }

 static var showColor = Colors.redAccent[100];
 static String day = '';

   viewPricing(BuildContext context,){
    var mediaqury = MediaQuery.of(context).size;
    showModalBottomSheet(context: context, isScrollControlled: true,builder: (BuildContext context){
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
        ),
        height: mediaqury.height*0.8,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: mediaqury.width*0.38,),
                      Center(child: Text('Pricing',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),)),
                      Spacer(),
                      IconButton(icon: Icon(Icons.close), onPressed: (){Navigator.of(context).pop();})
                    ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          day = '7 Days\n\t\t\t@\n25 USD';
                          showColor = Colors.redAccent[100];
                        });
                      },
                     child: Container(
                      width: mediaqury.width*0.3,
                      height: mediaqury.height*0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("7 Days",style: TextStyle(fontWeight: FontWeight.w900),),
                          SizedBox(height: 10,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.redAccent[100],
                            ),
                            height: 50,
                            width: 100,
                            child: Center(
                              child: Text("\$ 25",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black),),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          day = '30 Days\n\t\t\t\t@\n100 USD';
                          showColor = Colors.yellowAccent[100];
                        });
                      },
                      child: Container(
                        width: mediaqury.width*0.3,
                        height: mediaqury.height*0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("30 days",style: TextStyle(fontWeight: FontWeight.w900),),
                            SizedBox(height: 10,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.yellowAccent[100],
                              ),
                              height: 50,
                              width: 100,
                              child: Center(
                                child: Text("\$ 100",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black),),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          day = '365 Days\n\t\t\t\t\t@\n1100 USD';
                          showColor = Colors.greenAccent[100];
                        });
                      },
                      child: Container(
                        width: mediaqury.width*0.3,
                        height: mediaqury.height*0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("365 Days",style: TextStyle(fontWeight: FontWeight.w900),),
                            SizedBox(height: 10,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.greenAccent[100],
                              ),
                              height: 50,
                              width: 100,
                              child: Center(
                                child: Text("\$ 1100",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black),),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 200,
                      width: 115,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: showColor,
                      ),
                      child: Center(child: Text(day,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),),
                    ),
                    Container(
                      height: 200,
                      width: 115,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: showColor
                      ),
                      child: Center(child: Text(day,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),),
                    ),
                  ],
                ),
                SizedBox(height: 25,),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: (){_launchurl('contactwallper@gmail.com', 'Promotion', '');},
                      child: Text('Send Email')),
                )
              ]
          ),
        ),
      );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: title()
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            Text("         Send your portrait photographs with url at free of cost.  ",style: TextStyle(fontSize: 15),),
           SizedBox(height: 3,),
           Center(
             child: ElevatedButton(
               onPressed: () => _launchurl('contactwallper@gmail.com', 'Photographs', ''),
               child: Text("Send Email"),
             ),
           ),
            SizedBox(height: 10,),
            Text("         Send your Brand Promotions with url .  ",style: TextStyle(fontSize: 15),),
            SizedBox(height: 4,),
            Center(
              child: ElevatedButton(
                onPressed: (){
                  viewPricing(context);
                },
                child: Text("View Pricing"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}