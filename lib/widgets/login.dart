import 'package:flutter/material.dart';

TextEditingController loginUserController = TextEditingController();
TextEditingController loginPassController = TextEditingController();


class LogInCard extends StatelessWidget {
  const LogInCard({ Key? key }) : super(key: key);

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
            controller: loginUserController,
          
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
          controller: loginPassController,
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
          child: RaisedButton(onPressed: (){}, child: Text("LogIn" , style: TextStyle(color: Colors.white),)))
        


        ],
      ),

      ),
      
      
    );
  }
}