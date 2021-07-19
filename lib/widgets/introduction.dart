

import 'package:dbproject/models/Network.dart';
import 'package:dbproject/models/Notification.dart';
import 'package:dbproject/models/User.dart';
import 'package:dbproject/views/otherUserView.dart';
import 'package:dbproject/widgets/accomplishments.dart';
import 'package:dbproject/widgets/direct.dart';
import 'package:dbproject/widgets/editintro.dart';
import 'package:flutter/material.dart';
import '../database.dart';



TextEditingController searchLocationController = TextEditingController();

TextEditingController searchCompanyController = TextEditingController();

class SearchUserCard extends StatefulWidget {

  const SearchUserCard(this.db , this.username , this.id , this.myuser , this.mutual);
  final username ;
  final AppDatabase db ;
  final id ;
  final myuser ;
  final mutual ;
  @override
  _SearchUserCardState createState() => _SearchUserCardState();
}

class _SearchUserCardState extends State<SearchUserCard> {

  //send notif for see the profile
  void seenNotif()async{
    var notif = Notificationn(sender: widget.myuser, notificationType: 2, receiver: widget.id);
    await widget.db.notificationnDao.insertNotif(notif);
    print("after inserting seen notif");
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OtherUserView(widget.db , widget.id , widget.myuser)),);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 50,
      width: MediaQuery.of(context).size.width*0.2,
      color: Colors.redAccent,
      child: GestureDetector(
        onTap: (){
          return seenNotif();
        },
        child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10),
        child: Text(widget.username),),)
      
      
      
    );
  }
}


class Intro extends StatefulWidget {
  const Intro( { Key? key,required this.db ,required this.user}): super(key: key) ;
  final AppDatabase db ;
  final int? user  ;

  


  @override
  _IntroState createState() => _IntroState(

  );
}

class _IntroState extends State<Intro> {
  List<SearchUserCard> list = [];
  void addSearchCard(var db  , String? username , int? id,int mutualcon){
  list.add(new SearchUserCard(db , username , id , widget.user , mutualcon)
  );
  setState((){});
}
  String _textFromFile = 'im empty' ;
  String about = 'you have not filled about';
  var username = '';

  _IntroState() {
  }

  void makemy() async{
    var a = widget.user;
    // print('this is user in intro: $a');
    // var b = widget.db.userDao.findUserNameByUserId;
    // print('intro db is: $b');
    if (a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
        if (val != null){
          print("this is profileid in intro page");
          print(val.ProfileId);
          about = val.About;
          }
      }));

      print("i reached here");
        widget.db.userDao.findUserNameByUserId(a).then((val) => setState(() {
        print('val is : $val');
        if (val != null){
          _textFromFile = val.userName;
        } else {
          // _textFromFile = "kir";
        }
        }));
    } else {
      // _textFromFile = "kos";
    }
      
  }

  String giveme(){
      makemy();
      return _textFromFile;
  }

  List<int> parseNetwork(List<Network?> network, userId) { 
  List<int> myNet = [];

  for (var i in network){
    if (i?.userId == userId){
      var k = i?.userReqId;
        myNet.add(k!);
    } else {
      var j = i?.userId ;
      myNet.add(j!);
    }
  }

  return myNet;
}

  int findNumberOfMutualConnections(List network1,List network2) { 
  int n = 0;

  for (var i in network1){
    if (network2.contains(i)){
      n++;
    }
  }
  return n;
}
  



  List<String?> items = [] ;
  void searchUser(String text)async{
    print(text);
    var searchtext = "%"+text+"%" ;
    print(searchtext);
    print("get in searchUser function");

    widget.db.userDao.searchByUsername(searchtext.toString()).then((value) => setState((){
      list = [];

    //new search by mutual connection
    var mycons ;
    
    widget.db.netwokDao.allNetwork(widget.user!).then((v) => setState((){
      print("my connections found");
      mycons = parseNetwork(v, widget.user);
      print("mycons $mycons");

      for(int i = 0 ; i < value.length ; i++){
      var s = value[i]?.userId ;
      widget.db.netwokDao.allNetwork(s!).then((val) => setState((){
        print("another network");
        var hiscons = parseNetwork(val, s);
        print("hiscons $hiscons");
        int n = findNumberOfMutualConnections(mycons, hiscons);
        print("number of mutual connection $n");
        addSearchCard(widget.db , value[i]?.userName , value[i]?.userId , n);
        list.sort((a,b) =>b.mutual.compareTo(a.mutual));
        print(list);

      }));

    }

    }));


    //end








      // var mmd = value ;
      // print("search started");
      // // mylist = value ;
      // if (value != null ){
      //   print(value);
      //   for (int i = 0 ; i < value.length ; i++){
      //     if(value[i] != null){
      //       print("value i is not null");
      //       print(value[i]?.userName);

      //       var hiscons = parseNetwork(network, userId)
      //       addSearchCard(widget.db , value[i]?.userName , value[i]?.userId);
      //       // items.add(value[i]?.userName);
      //       // print(value[i]?.userName);
      //     }
      //     else{
      //       print("value[i] is null");
      //     }
          
      // }
      // }
      // else{
      //   print("value is null");
      // }
    }));

    for(int i = 0 ; i < items.length ; i++){
      items[i] = items[i].toString();
    }


  }


  void searchLocation(String text)async{
    var searchtext = "%"+text+"%" ;
    var a = widget.user;
    


  }
  

  @override
  void initState() {
    username = giveme();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Container(
          margin: EdgeInsets.only(top: 20),
      height: 400,
      width: MediaQuery.of(context).size.width * 0.7,
      color: Colors.redAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
        Container(

          color: Colors.white12,
          width: MediaQuery.of(context).size.width * 0.9,
          height: 150, child :
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
          child: Text(about.toString(),
          style: TextStyle(color: Colors.white , fontSize: 13),
          ),
        )

      ],),
        ),

        Container(
          margin: EdgeInsets.only(top: 20),
          height: 400,
          width: MediaQuery.of(context).size.width * 0.2,
          color: Colors.redAccent[100],

          child: Column(children: [
            Container(
          color: Colors.redAccent,
          child: Column(children: [
              Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: 50,
          child: TextField(
            style: TextStyle(color: Colors.blue),
                controller: searchUserController,
                decoration: InputDecoration(
                  hintText: "Search user",
                  fillColor: Colors.blue,
                  contentPadding: EdgeInsets.only(left: 10 , top: 15),
                  hintStyle: TextStyle(color: Colors.blue),
                  suffixIcon: IconButton(
                    onPressed: () {
                      return searchUser(searchUserController.text);
                    },
                    icon: Icon(Icons.search),
                    
                    
             ),
                ),
              ),
        ),


        // TextButton(onPressed:(){}, child: Text("Add")) ,

      ],) ,

            Container(
          width: 250,
          height: 50,
          child: TextField(
            style: TextStyle(color: Colors.blue),
                controller: searchLocationController,
                decoration: InputDecoration(
                  hintText: "Search location",
                  fillColor: Colors.blue,
                  contentPadding: EdgeInsets.only(left: 10 , top: 15),
                  hintStyle: TextStyle(color: Colors.blue),
                  suffixIcon: IconButton(
                    onPressed: () {
                      return searchUser(searchUserController.text);
                    },
                    icon: Icon(Icons.search),
                    
                    
             ),
                ),
              ),
        ),

          Container(
          width: 250,
          height: 50,
          child: TextField(
            style: TextStyle(color: Colors.blue),
                controller: searchCompanyController,
                decoration: InputDecoration(
                  hintText: "Search current company",
                  fillColor: Colors.blue,
                  contentPadding: EdgeInsets.only(left: 10 , top: 15),
                  hintStyle: TextStyle(color: Colors.blue),
                  suffixIcon: IconButton(
                    onPressed: () {
                      return searchUser(searchUserController.text);
                    },
                    icon: Icon(Icons.search),
                    
                    
             ),
                ),
              ),
        ),

          ],),
          
          
      ),
            Flexible(child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (_,index) => SearchUserCard( widget.db ,list[index].username , list[index].id , widget.user,list[index].mutual)))

          ],),

        )

      ],),
      ),

      
      


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



class OtherIntro extends StatefulWidget {
  const OtherIntro( { Key? key,required this.db ,required this.user}): super(key: key) ;
  final AppDatabase db ;
  final int? user  ;

  @override
  _OtherIntroState createState() => _OtherIntroState();
}

class _OtherIntroState extends State<OtherIntro> {
  String _textFromFile = 'im empty' ;
  String about = 'you have not filled about';
  var username = '';

  void makemy() async{
    var a = widget.user;
    // print('this is user in intro: $a');
    // var b = widget.db.userDao.findUserNameByUserId;
    // print('intro db is: $b');
    if (a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
        if (val != null){
          print("this is profileid in intro page");
          print(val.ProfileId);
          about = val.About;
          }
      }));

      print("i reached here");
        widget.db.userDao.findUserNameByUserId(a).then((val) => setState(() {
        print('val is : $val');
        if (val != null){
          _textFromFile = val.userName;
        } else {
          // _textFromFile = "kir";
        }
        }));
    } else {
      // _textFromFile = "kos";
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
          height: 70,
        )
        
        ,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          
          
          Container(
          margin: EdgeInsets.only(left: 10 ),
          child: Text(_textFromFile , 
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),

        
        
        ],),

        
        Container(
          margin: EdgeInsets.only(left: 10 , top: 5),
          child: Text(about.toString() ,
          style: TextStyle(color: Colors.white , fontSize: 13),
          ),
        )

      ],),
      
    );
  }
}
// class OtherIntro extends StatelessWidget {
//   //const OtherIntro({ Key? key }) : super(key: key);
//   final AppDatabase db ;
//   const OtherIntro(this.db);

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
//           height: 70,
//         )
        
//         ,
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
          
          
//           Container(
//           margin: EdgeInsets.only(left: 10 ),
//           child: Text("profile.userName" , 
//           style: TextStyle(color: Colors.white , fontSize: 15),
//           ),
//         ),

        
        
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




