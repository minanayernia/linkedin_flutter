import 'package:flutter/material.dart';

class EditIntrCard extends StatelessWidget {
  const EditIntrCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height*0.35,
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.black87,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [


        Container(
          margin: EdgeInsets.only(left: 10),
          height: 40,
        alignment: Alignment.centerLeft,
        child: Text("EDIT INTRO" , 
        style: TextStyle(color: Colors.white , fontSize: 20),),
        ),

        Container(
          color: Colors.redAccent,
          child:TextField(
          
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            fillColor: Colors.white,
          border: OutlineInputBorder(),
          hintText: 'FisrtName' , 
          hintStyle: TextStyle(color: Colors.white)
  ),
          
        ) ,),
        
        Container(
          color: Colors.redAccent,
          child:TextField(
          decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'LastName',
          hintStyle: TextStyle(color: Colors.white)
  ),
          
        ) ,),


         Container(
          color: Colors.redAccent,
          child:TextField(
          decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'About',
          hintStyle: TextStyle(color: Colors.white)
  ),
          
        ) ,),
        

        Container(
          color: Colors.redAccent,
          child:TextField(
          decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Location',
          hintStyle: TextStyle(color: Colors.white)
  ),
          
        ) ,),
        Container(
          alignment: Alignment.centerRight,
          child:TextButton(onPressed: (){}, child: Text("Save" , style: TextStyle(color: Colors.white),))
        
         ,)
        


        ],
      ),

      
    );
  }
}