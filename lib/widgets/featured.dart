import 'package:flutter/material.dart';



class FeaturedList extends StatefulWidget {
  const FeaturedList({ Key? key }) : super(key: key);

  @override
  _FeaturedListState createState() => _FeaturedListState();
}

class _FeaturedListState extends State<FeaturedList> {
List<FeaturedCard> list = [];
addSkillCard(){
  
  list.add(new FeaturedCard()
  );
  setState((){});
}
  @override
  Widget build(BuildContext context) {
    return Container(

              margin: EdgeInsets.only(top: 20),

      height: 200,
      width: MediaQuery.of(context).size.width*0.9,
      color: Colors.black87,
      child: 
      Column(children: [
        Container(
          color: Colors.redAccent,
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        Container(
          
          margin: EdgeInsets.only(left: 10),
          child: Text("FEATURED",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),
        TextButton(onPressed: addSkillCard, child: Text("Add")) ,

      ],) ,),
        

      Flexible(child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) => list[index]))
      

      ], 
      )

      
    );
  }
}


class FeaturedCard extends StatelessWidget {
  const FeaturedCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 50,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.redAccent,
      child: Container(margin: EdgeInsets.only(left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text("article" , style: TextStyle(color: Colors.white),) ,
        TextButton(onPressed: (){}, child: Text("Edit")),

      ],)
      )
      
    );
  }
}