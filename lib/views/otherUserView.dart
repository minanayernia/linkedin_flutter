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

  void refresh() {
      setState(() {});
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text("back")),
            NavigationBar(widget.db,widget.user , widget.myuser , refresh),

            
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              margin: EdgeInsets.only(top:20 ),
              alignment: Alignment.bottomRight,
              child:  ButtonTheme(
          height: 40,
          minWidth: MediaQuery.of(context).size.width*0.1,
          buttonColor: Colors.redAccent,
          child: RaisedButton(onPressed: ()=> Navigator.of(context).pop(true),
           child: Text("Back to my page" , style: TextStyle(color: Colors.white),))) ,),
           
            OtherIntro (db: widget.db, user: widget.user,),
            OtherAdditionalInfo(widget.db , widget.user) ,
            OtherAccomplish(widget.db , widget.user),
            OtherSkill(widget.db , widget.user , widget.myuser) ,
            OtherFeature(widget.db , widget.user , widget.myuser),
            OtherLanguage(widget.db , widget.user),
            OtherPost(widget.db,widget.user,widget.myuser) ,
            // AddPost(widget.db , widget.user),
            

          ],
        ),
      ),
      
    );
  }
}