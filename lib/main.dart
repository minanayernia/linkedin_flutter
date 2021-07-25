import 'package:dbproject/models/User.dart';
import 'package:dbproject/views/signUpLoginView.dart';
import 'package:dbproject/widgets/featured.dart';
import 'package:dbproject/widgets/test.dart';
import 'package:flutter/material.dart';
//import 'dart:async';

//import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';
import 'package:dbproject/database.dart';
import 'package:dbproject/widgets/accomplishments.dart';
import 'package:dbproject/widgets/direct.dart';
import 'package:dbproject/widgets/editIntro.dart';
// import 'package:dbproject/navigationBar.dart';
import 'package:dbproject/widgets/additionalinformation.dart';
//import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';
// import 'package:dbproject/views/homeView.dart';
import 'package:dbproject/widgets/introduction.dart';
import 'package:dbproject/widgets/navigationBar.dart';
import 'package:dbproject/widgets/notification.dart';
import 'package:dbproject/widgets/postCard.dart';
import 'package:dbproject/widgets/supportedLanguage.dart';
import 'package:dbproject/widgets/skillsAndEndorsement.dart';
import 'package:dbproject/widgets/login.dart';
import 'package:dbproject/widgets/signUp.dart';
import 'package:dbproject/widgets/myNetwork.dart';
import 'database.dart';



void main() async {
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  // final userDao = database.userDao ;
  //   final result = await userDao.findAllusers();
    // print(result);
  runApp(MyApp(database));
}

class MyApp extends StatelessWidget {
  final database ;
  
  const MyApp(this.database);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      
      home:
      // StatefullWidgetDemo(),
      SignUpLogIn(database)
      //  MyHomePage(database),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // final String userName ;
  // final String password ;
  final int? user ;
  final AppDatabase db ;

  MyHomePage(this.db ,this.user  );

  // final String title;

  @override

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(){
    // print("here is home page");
    // if(widget.user==null){
    //   print("leave me alooooneeeeeeeee");
    // }
    // if (widget.user != null){
    //   print("this is not null") ;
    //   print(widget.user);
    // }
  }
   void rebuildAllChildren(BuildContext context) {
      void rebuild(Element el) {
        el.markNeedsBuild();
        el.visitChildren(rebuild);
      }
      (context as Element).visitChildren(rebuild);
    }
    int test = 0 ;
  @override
  Widget build(BuildContext context) {

    print("rebuilding home");
    var a = widget.user;
    print('this is userid in myhome: $a');
    void refresh() {
      if (this.mounted) {
      setState(() {
    // Your state change code goes here
  });
}
    }

   
  
    return Scaffold(
      // appBar: AppBar(actions: [TextButton(onPressed: () => setState((){rebuildAllChildren(context);}) , child: Text("rebuild" , style: TextStyle(color: Colors.red),))],),
      backgroundColor: Colors.white,
  body: SingleChildScrollView(
    child: Column(

      crossAxisAlignment: CrossAxisAlignment.center,
    children: [
          // RaisedButton(
          //   key: UniqueKey(),
          //     child: Text('Click me'),
          //     onPressed: () {
          //       setState(() {});
          //     },
          //   ),
          NavigationBar(widget.db , widget.user , widget.user, refresh),
          Intro( db : widget.db , user :widget.user ,notifyParent: refresh,),
          EditIntrCard( db : widget.db , user :widget.user),
          AdditionalInfoList(widget.db , widget.user),
          EditInfoCard(widget.db , widget.user),
          AddSkill(widget.db , widget.user),
          EditSkillCard(widget.db , widget.user),
          AddAccomplish(widget.db , widget.user),
          EditAccomplishCard(widget.db , widget.user),
          FeaturedList(widget.db , widget.user),
          EditFeaturedCard(widget.db , widget.user),
          AddPost(widget.db , widget.user),
          PostList(widget.db,widget.user),
          NotifList(widget.db , widget.user),
          LanguageList(widget.db , widget.user),
          EditLanguageCard(widget.db , widget.user),
          Message(widget.db , widget.user) ,
          NewMessage(widget.db , widget.user) ,
          InvitationList(widget.user , widget.db),
          PeopleYouMayKnowList(widget.db , widget.user),
          HomePosts(widget.db , widget.user),
          LikeCommentPost(widget.db, widget.user ),
          
      // SignUpLogIn()
      
          
  ],
    ),
    ),

    );
  }
}
