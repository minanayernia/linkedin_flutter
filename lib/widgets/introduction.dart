

import 'package:flutter/material.dart';
import '../database.dart';
class Intro extends StatelessWidget {
  final AppDatabase db ;
  final user ;
  const Intro( this.db , this.user) ;

  void fuck()async{
    final res = await db.userDao.findUserNameByUserId(user);
    print("fuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuck");
    print(res);
    // final res2= res?.userName ;
    // return res2 ;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 200,
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.redAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
        Container(

          color: Colors.white12,
          width: MediaQuery.of(context).size.width * 0.9,
          height: 70, child :
          Stack( 
            
            children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(onPressed: (){},
                 child:Text("camera")),
            )
          ],
            
          ),
        )
        
        ,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          
          
          Container(
          margin: EdgeInsets.only(left: 10 ),
          child: 
          FutureBuilder(
            future: db.userDao.findUserNameByUserId(user),
            builder:  (context, snapshot) {
              // print(user);
              // final result = db.userDao.findUserNameByUserId(user);
              // print( result);
              // print("33333333333333333333");
              fuck();
                if (snapshot.hasError) {
                  return Text("Errror ${snapshot.error}");
                }
                print(Text(snapshot.data.toString()));
                return Text(snapshot.data.toString());
              },)
          // Text( db.userProfileDao.findProfileByUserId(user).toString())
          // FutureBuilder(
          //   future: db.userProfileDao.findProfileByUserId(user),
          //   builder:  (context, snapshot) {
          //     print(user);
          //     print("33333333333333333333");
          //       if (snapshot.hasError) {
          //         return Text("Errror ${snapshot.error}");
          //       }
          //       return Text(snapshot.data.toString());
          //     },
          // )
        ),

        TextButton(onPressed: (){}, child: Text("Edit"))
        
        
        ],),

        
        Container(
          margin: EdgeInsets.only(left: 10 , top: 5),
          child: Text("profile.about" ,
          style: TextStyle(color: Colors.white , fontSize: 13),
          ),
        )

      ],),

    );
  }
}



/*var profile = Profile(userName: "bahar" , about: "jfngsdmvslfjb") ;*/


class OtherIntro extends StatelessWidget {
  //const OtherIntro({ Key? key }) : super(key: key);
  final AppDatabase db ;
  const OtherIntro(this.db);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 200,
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.redAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
        Container(

          color: Colors.white12,
          width: MediaQuery.of(context).size.width * 0.9,
          height: 70,
        )
        
        ,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          
          
          Container(
          margin: EdgeInsets.only(left: 10 ),
          child: Text("profile.userName" , 
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),

        
        
        ],),

        
        Container(
          margin: EdgeInsets.only(left: 10 , top: 5),
          child: Text("profile.about" ,
          style: TextStyle(color: Colors.white , fontSize: 13),
          ),
        )

      ],),
      
    );
  }
}