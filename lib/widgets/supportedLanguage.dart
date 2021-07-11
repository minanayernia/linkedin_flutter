import 'package:flutter/material.dart';


class LanguageList extends StatefulWidget {
  const LanguageList({ Key? key }) : super(key: key);

  @override
  _LanguageListState createState() => _LanguageListState();
}

class _LanguageListState extends State<LanguageList> {
         List<LanguageCard> list = [];
addSkillCard(){
  
  list.add(new LanguageCard()
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
          child: Text("LANGUAGES",
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
class LanguageCard extends StatelessWidget {
  const LanguageCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.redAccent,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text("data" , 
          style: TextStyle(color: Colors.white , fontSize: 13),
          ),
        ),
        Row(children: [
        TextButton(onPressed: (){}, child: Text("Delete")),
        TextButton(onPressed: (){}, child: Text("Edit"))
        ],)
        

      ],),
      
    );
  }
}