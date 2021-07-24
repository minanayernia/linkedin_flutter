

import 'dart:math';

import 'package:dbproject/models/Network.dart';
import 'package:dbproject/models/Notification.dart';
import 'package:dbproject/models/User.dart';
import 'package:dbproject/views/otherUserView.dart';
import 'package:dbproject/widgets/accomplishments.dart';
// import 'package:dbproject/widgets/direct.dart';
import 'package:dbproject/widgets/editintro.dart';
import 'package:flutter/material.dart';
import '../database.dart';

class LocationCompanyUserCard extends StatefulWidget {
  const LocationCompanyUserCard(this.db , this.username , this.id , this.myuser);
  final username ;
  final AppDatabase db ;
  final id ;
  final myuser ;


  @override
  _LocationCompanyUserCardState createState() => _LocationCompanyUserCardState();
}

class _LocationCompanyUserCardState extends State<LocationCompanyUserCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 50,
      width: MediaQuery.of(context).size.width*0.2,
      color: Colors.redAccent, 
        child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10),
        child: Text(widget.username),),
      
    );
  }
}
TextEditingController searchUserController = TextEditingController();
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
        child: Row(children: [
          Text(widget.username),
          Text(widget.mutual.toString())
        ],)
        
        ,),)
      
      
      
    );
  }
}


class Intro extends StatefulWidget {
  const Intro( { Key? key,required this.db ,required this.user ,required this.notifyParent}): super(key: key) ;
  final AppDatabase db ;
  final int? user  ;
  final Function() notifyParent;

  


  @override
  _IntroState createState() => _IntroState(

  );
}

class _IntroState extends State<Intro> {
  List<SearchUserCard> list = [];
  List<LocationCompanyUserCard> listLocation = [] ;
  
  void addSearchCard(var db  , String? username , int? id,int mutualcon){
  list.add(new SearchUserCard(db , username , id , widget.user , mutualcon)
  );
  setState((){});
}

void getbirthday()async{

  widget.db.netwokDao.allNetwork(widget.user!).then((value) => setState((){
    var mycons = parseNetwork(value, widget.user);
    for(var i in mycons){
      widget.db.userDao.findUserNameByUserId(i).then((val) => setState((){
        var bir = val?.birthday ;
        DateTime today = DateTime.now();
        if(today.day == bir?.day){
          print("day is checked");
          if(today.month == bir?.month){
            print("month is checked");
            var notif = Notificationn(notificationType: 1, receiver: widget.user, sender: val?.userId);
            widget.db.notificationnDao.insertNotif(notif);
            print("birth day notif send!");

          }
        }
      }));
    }
  }));
}

  void addLocationCompanyCard(var db  , String? username , int? id){
  listLocation.add(new LocationCompanyUserCard(db , username , id , widget.user)
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
    list.clear();
    listLocation.clear();
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

      print("mycons in search $mycons");

      for(int i = 0 ; i < value.length ; i++){
      var s = value[i]?.userId ;
      widget.db.netwokDao.allNetwork(s!).then((val) => setState((){
        print("another network");
        var hiscons = parseNetwork(val, s);
        print("hiscons in search $hiscons");
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
    list.clear();
    listLocation.clear();
    var searchtext = "%"+text+"%" ;
    var a = widget.user;
    widget.db.userProfileDao.filterByLocation(searchtext).then((value) => setState((){
          print("we r finding location");
          if(value != null){
            for(int i = 0 ; i < value.length ; i++){
                var ui = value[i].userId ;
                widget.db.userDao.findUserNameByUserId(ui!).then((val) => setState((){
                  if(val != null){
                      var un = val.userName;
                      print("ui is : $ui");
                      addLocationCompanyCard(widget.db , un , value[i].userId) ;
                  }

                }));
                
            }
          }
          else{
            
          }

    }));
    


  }

  void searchCompany(String text)async{
    listLocation.clear();
    list.clear();
    List<int> jobid = [];
    var searchtext = "%"+text+"%" ;
    widget.db.userProfileDao.filterByCompanyname(searchtext).then((value) => setState((){
      if(value != null){
        for(int i = 0 ; i <value.length ; i++){
            var ui = value[i].ProfileId;
            widget.db.additionalInfoDao.findJobById(ui!).then((val) => setState((){
                      // var un = val?.userName;
                      print("ui is : $ui");
                      if(val != null){
                        for(int j = 0 ; j < val.length ; j++){
                          var ji = val[j].jobId;
                          var t = val[j].companyName;
                          print("t is :$t");
                          print("ji is $ji");
                          jobid.add(ji!);

                        }
                       int m =  jobid.reduce((a, b) => a > b ? a : b);
                       print("m : $m");
                       
                        widget.db.userProfileDao.findProfileByJobId(searchtext, m).then((v) => setState((){
                            if(v != null){
                              widget.db.userDao.findUserNameByUserId(v.userId!).then((vl) => setState((){
                                      var un = vl?.userName;
                                      addLocationCompanyCard(widget.db , un , v.userId) ;
                              }));
                              
                            }
                        }));
                      }
                      
            }));
        }
      }
    }));

  }

  // @override
  // void setState(VoidCallback fn) {
  //   username = giveme();
  //   getbirthday();
  //   super.setState(fn);
  // }
  

  @override
  void initState() {
    username = giveme();
    getbirthday();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    // makemy();
    print("rebuilding intro");
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
          // TextButton(onPressed: () => widget.notifyParent(), child: Text("refresh")),
        
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
                      return searchLocation(searchLocationController.text);
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
                      return searchCompany(searchCompanyController.text);
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
            itemBuilder: (_,index) => SearchUserCard( widget.db ,list[index].username , list[index].id , widget.user,list[index].mutual))),

            //  Flexible(child: ListView.builder(
            // itemCount: listLocation.length,
            // itemBuilder: (_,index) => LocationCompanyUserCard( widget.db ,listLocation[index].username , listLocation[index].id , widget.user))),


            Flexible(child: ListView.builder(
            itemCount: listLocation.length,
            itemBuilder: (_,index) => LocationCompanyUserCard( widget.db ,listLocation[index].username , listLocation[index].id , widget.user)))

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




