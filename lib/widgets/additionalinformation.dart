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


TextEditingController infoController = TextEditingController();
class EditInfoCard extends StatelessWidget {
  const EditInfoCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 50,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.redAccent,
      child: Container(margin: EdgeInsets.only(left: 5),
      child: 
        TextField(
            controller: infoController,
            decoration: InputDecoration(
            hintText: "Edit field",
            suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.check),
             ),
              ),
              ),

    
      )
      
    );
  }
}


class OtherAdditionalInfo extends StatelessWidget {
  const OtherAdditionalInfo({ Key? key }) : super(key: key);

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

          ],),
        )
      ],)
      
    );
  }
}