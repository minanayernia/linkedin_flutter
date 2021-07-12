import 'package:flutter/material.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({ Key ?key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      color: Colors.black87,
      height: 100,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
        Container(
          height: 30,
          color: Colors.redAccent,
          child: Row(children: [
            Container(
          margin: EdgeInsets.only(left: 10),
          child:  Text("ADDITIONALINFO",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),

        ),
        ],),),
        
        Container(
          margin: EdgeInsets.only(left: 10 , top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text("data" , 
            style: TextStyle(color: Colors.white , fontSize: 13),
            ) ,
            TextButton(onPressed: (){}, child: Text("Edit"))

          ],),
        )
      ],)
      
    );
  }
}