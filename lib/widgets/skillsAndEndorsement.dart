

import 'package:flutter/material.dart';



class SkillsAndEndorsements extends StatelessWidget {
  const SkillsAndEndorsements({ Key ?key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      
      
    );
  }
}


class SkillCard extends StatelessWidget {
  const SkillCard({ Key ?key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5 , bottom: 5),
      height: 50,
      width: MediaQuery.of(context).size.width*0.86,
      color: Colors.redAccent,
      child: Container(margin: EdgeInsets.only(left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text("Skill" , style: TextStyle(color: Colors.white),),
        Row(children: [
          TextButton(onPressed: (){}, child: Text("Endorse")),
          TextButton(onPressed: (){}, child: Text("Edit")),
        ],)

      ],),
      )
      
    );
  }
}

class AddSkill extends StatefulWidget {

  const AddSkill({ Key ?key }) : super(key: key);
 

  @override
  _AddSkillState createState() => _AddSkillState();
}

class _AddSkillState extends State<AddSkill> {
     List<SkillCard> list = [];
addSkillCard(){
  
  list.add(new SkillCard()
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
          child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        Container(
          
          margin: EdgeInsets.only(left: 10),
          child: Text("SKILLS&ENDORSEMENTS",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),
        TextButton(onPressed: addSkillCard, child: Text("Add skill")) ,

      ],) ,),
        

      Flexible(child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) => list[index]))
      
      ] 
      ,)
      
      
    );
  }
}

