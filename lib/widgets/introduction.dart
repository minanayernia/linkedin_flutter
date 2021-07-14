

import 'package:dbproject/models/User.dart';
import 'package:flutter/material.dart';
import '../database.dart';

class Intro extends StatefulWidget {
  const Intro( { Key? key,required this.db ,required this.user}): super(key: key) ;
  final AppDatabase db ;
  final int? user  ;

  


  @override
  _IntroState createState() => _IntroState(

  );
}

class _IntroState extends State<Intro> {
  String _textFromFile = 'im empty' ;
  var username = '';

  _IntroState() {
  }

  void makemy() async{
    var a = widget.user;
    // print('this is user in intro: $a');
    // var b = widget.db.userDao.findUserNameByUserId;
    // print('intro db is: $b');
    if (a != null){
      print("i reached here");
        widget.db.userDao.findUserNameByUserId(a).then((val) => setState(() {
        print('val is : $val');
        if (val != null){
          _textFromFile = val.userName;
        } else {
          _textFromFile = "kir";
        }
          print("ooooooooooooooooooooooooooooooooooooooo");
          print(_textFromFile);
        }));
    } else {
      _textFromFile = "kos";
    }
      
  }

  String giveme(){
      makemy();
      return _textFromFile;
  }

  @override
  void initState() {
    username = giveme();
    super.initState();
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
          child: Text(_textFromFile , style: TextStyle(color: Colors.white),) ,
          
          // FutureBuilder(
          //   future: db.userDao.findUserNameByUserId(user),
          //   builder:  (context, snapshot) {
          //     // print(user);
          //     // final result = db.userDao.findUserNameByUserId(user);
          //     // print( result);
          //     // print("33333333333333333333");
          //     fuck();
          //       if (snapshot.hasError) {
          //         return Text("Errror ${snapshot.error}");
          //       }
          //       print(Text(snapshot.data.toString()));
          //       return Text(snapshot.data.toString());
          //     },)
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

  // u = User(password: "" , userName: "" );
// class Intro extends StatelessWidget {
//   final AppDatabase db ;
//   final user ;
//   const Intro( this.db , this.user) ;


//   void fuck()async{
//     final res = await db.userDao.findUserNameByUserId(user);
//     // u.userId = res?.userId ;
//     // u.userName = res?.userName ;


//     print("fuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuck");
//     print(user);
//     print(res);
     
//     // final res2= res?.userName ;
//     // return res2 ;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 20),
//       height: 200,
//       width: MediaQuery.of(context).size.width * 0.9,
//       color: Colors.redAccent,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
        
//         Container(

//           color: Colors.white12,
//           width: MediaQuery.of(context).size.width * 0.9,
//           height: 70, child :
//           Stack( 
            
//             children: [
//             Align(
//               alignment: Alignment.topRight,
//               child: TextButton(onPressed: (){},
//                  child:Text("camera")),
//             )
//           ],
            
//           ),
//         )
        
//         ,
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
          
          
//           Container(
            
//           margin: EdgeInsets.only(left: 10 ),
//           child: 
          
//           // FutureBuilder(
//           //   future: db.userDao.findUserNameByUserId(user),
//           //   builder:  (context, snapshot) {
//           //     // print(user);
//           //     // final result = db.userDao.findUserNameByUserId(user);
//           //     // print( result);
//           //     // print("33333333333333333333");
//           //     fuck();
//           //       if (snapshot.hasError) {
//           //         return Text("Errror ${snapshot.error}");
//           //       }
//           //       print(Text(snapshot.data.toString()));
//           //       return Text(snapshot.data.toString());
//           //     },)
//           // Text( db.userProfileDao.findProfileByUserId(user).toString())
//           // FutureBuilder(
//           //   future: db.userProfileDao.findProfileByUserId(user),
//           //   builder:  (context, snapshot) {
//           //     print(user);
//           //     print("33333333333333333333");
//           //       if (snapshot.hasError) {
//           //         return Text("Errror ${snapshot.error}");
//           //       }
//           //       return Text(snapshot.data.toString());
//           //     },
//           // )
//         ),

//         TextButton(onPressed: (){}, child: Text("Edit"))
        
        
//         ],),

        
//         Container(
//           margin: EdgeInsets.only(left: 10 , top: 5),
//           child: Text("profile.about" ,
//           style: TextStyle(color: Colors.white , fontSize: 13),
//           ),
//         )

//       ],),

//     );
//   }
// }



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




