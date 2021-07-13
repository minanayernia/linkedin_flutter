import 'package:dbproject/models/User.dart';
import 'package:dbproject/views/signUpLoginView.dart';
import 'package:dbproject/widgets/featured.dart';
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
      
      home:SignUpLogIn(database)
      //  MyHomePage(database),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Stream<User?> user ;
  final AppDatabase db ;

  MyHomePage(this.db , this.user);

  // final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: Colors.white,
  body: SingleChildScrollView(
    child: Column(

      crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      NavigationBar(),
          
          Intro(),
          EditIntrCard(),
          AdditionalInfoList(),
          AddSkill(),
          AddAccomplish(),
          FeaturedList(),
          AddPost(),
          PostList(),
          NotifList(),
          LanguageList(),
          Message() ,
          NewMessage() ,
          InvitationList(),
          PeopleYouMayKnowList(),
      // SignUpLogIn()
      
          
  ],
    ),
    ),

    );
  }
}
