import 'package:dbproject/models/User.dart';
import 'package:dbproject/widgets/accomplishments.dart';
import 'package:dbproject/widgets/additionalinformation.dart';
import 'package:dbproject/widgets/introduction.dart';
import 'package:dbproject/widgets/navigationBar.dart';
import 'package:dbproject/widgets/postCard.dart';
import 'package:dbproject/widgets/skillsAndEndorsement.dart';
import 'package:dbproject/widgets/featured.dart';
import 'package:dbproject/widgets/supportedLanguage.dart';
import 'package:flutter/material.dart';
import '../database.dart';
import 'package:dbproject/widgets/myNetwork.dart';






class OtherUserView extends StatefulWidget {
  
  //const OtherUserView({ Key? key }) : super(key: key);
  const OtherUserView( this.db , this.user , this.myuser) ;
  final AppDatabase db ;
  final user ;
  final myuser ;

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
            NavigationBar(widget.db,widget.user , widget.myuser),
            OtherIntro (db: widget.db, user: widget.user,),
            OtherAdditionalInfo(widget.db , widget.user) ,
            OtherAccomplish(widget.db , widget.user),
            OtherSkill(widget.db , widget.user) ,
            OtherFeature(widget.db , widget.user),
            OtherLanguage(),
            OtherPost(widget.db,widget.user,widget.myuser) ,
            // AddPost(widget.db , widget.user),
            

          ],
        ),
      ),
      
    );
  }
}