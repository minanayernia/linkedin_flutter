import 'package:flutter/material.dart';

class SignUpCard extends StatelessWidget {
  const SignUpCard({ Key ?key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child : Container(
      margin: EdgeInsets.only(top: 50),
      height: MediaQuery.of(context).size.height*0.5,
      width: MediaQuery.of(context).size.width * 0.6,
      color: Colors.black87,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [


        Container(
          margin: EdgeInsets.only(left: 10),
          height: 40,
        alignment: Alignment.centerLeft,
        child: Text("SIGNUP" , 
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
        
      ButtonTheme(
          height: 40,
          minWidth: MediaQuery.of(context).size.width*0.55,
          buttonColor: Colors.white,
          child: RaisedButton(onPressed: (){}, child: Text("SignUp" , style: TextStyle(color: Colors.redAccent),)))

        ],
      ),
      ),
      
    );
  }
}