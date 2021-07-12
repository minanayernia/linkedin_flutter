import 'package:dbproject/widgets/additionalinformation.dart';
import 'package:dbproject/widgets/introduction.dart';
import 'package:dbproject/widgets/navigationBar.dart';
import 'package:flutter/material.dart';
import '../database.dart';






class OtherUserView extends StatefulWidget {
  
  //const OtherUserView({ Key? key }) : super(key: key);
  const OtherUserView( this.db) ;
  final AppDatabase db ;

  @override
  _OtherUserViewState createState() => _OtherUserViewState();
}

class _OtherUserViewState extends State<OtherUserView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NavigationBar(),
            //OtherIntro(db),
            OtherAdditionalInfo() ,


          ],
        ),
      ),
      
    );
  }
}