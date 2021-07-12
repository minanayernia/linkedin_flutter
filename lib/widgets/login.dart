import 'package:dbproject/views/homeView.dart';
import 'package:flutter/material.dart';

import '../database.dart';



class LogInCard extends StatelessWidget {
  
  const LogInCard(this.db) ;
  final AppDatabase db ;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child : Container(
      margin: EdgeInsets.only(top: 50),
      height: MediaQuery.of(context).size.height*0.5,
      width: MediaQuery.of(context).size.width * 0.6,
      color: Colors.white60,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [


        Container(
          margin: EdgeInsets.only(left: 10),
          height: 40,
        alignment: Alignment.centerLeft,
        child: Text("LOGIN" , 
        style: TextStyle(color: Colors.redAccent , fontSize: 20),),
        ),

        Container(
          color: Colors.white,
          child:TextField(
          
          style: TextStyle(color: Colors.redAccent),
          decoration: InputDecoration(
            fillColor: Colors.white,
          border: OutlineInputBorder(),
          hintText: 'UserName' , 
          hintStyle: TextStyle(color: Colors.redAccent)
  ),
          
        ) ,),
        
        Container(
          color: Colors.white,
          child:TextField(
          decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.redAccent)
  ),
          
        ) ,),

        ButtonTheme(
          height: 40,
          minWidth: MediaQuery.of(context).size.width*0.55,
          buttonColor: Colors.redAccent,
          child: RaisedButton(onPressed: (){
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeView()),
  );
          },
           child: Text("LogIn" , style: TextStyle(color: Colors.white),)))
        


        ],
      ),

      ),
      
      
    );
  }
}