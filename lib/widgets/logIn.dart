import 'package:flutter/material.dart';



class LogInCard extends StatelessWidget {
  const LogInCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child : Container(
      margin: EdgeInsets.only(top: 50),
      height: MediaQuery.of(context).size.height*0.2,
      width: MediaQuery.of(context).size.width * 0.6,
      color: Colors.black87,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [


        Container(
          margin: EdgeInsets.only(left: 10),
          height: 40,
        alignment: Alignment.centerLeft,
        child: Text("LOGIN" , 
        style: TextStyle(color: Colors.white , fontSize: 20),),
        ),

        Container(
          color: Colors.redAccent,
          child:TextField(
          
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            fillColor: Colors.white,
          border: OutlineInputBorder(),
          hintText: 'UserName' , 
          hintStyle: TextStyle(color: Colors.white)
  ),
          
        ) ,),
        
        Container(
          color: Colors.redAccent,
          child:TextField(
          decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.white)
  ),
          
        ) ,),
        


        ],
      ),

      ),
      
      
    );
  }
}