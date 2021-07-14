

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
        Row(children: [
            Text("1" , style: TextStyle(color: Colors.white),) ,
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Text("Skill" , style: TextStyle(color: Colors.white),),)
            


        ],),
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



class OtherSkill extends StatelessWidget {
  const OtherSkill({ Key? key }) : super(key: key);

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
          height: 30 ,
          margin: EdgeInsets.only(left: 10 , top: 7),
          child: Text("SKILLS&ENDORSEMENTS",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),

      ],) ,),
        
      OtherSkillCard(),
      /*Flexible(child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) => list[index]))*/
      
      ] 
      ,)
      
    );
  }
}

class OtherSkillCard extends StatelessWidget {
  const OtherSkillCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10 , bottom: 5),
      height: 50,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.redAccent,
      child: Container(margin: EdgeInsets.only(left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Row(children: [
            Text("1" , style: TextStyle(color: Colors.white),) ,
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Text("Skill" , style: TextStyle(color: Colors.white),),)
            


        ],),
        Row(children: [
          TextButton(onPressed: (){}, child: Text("Endorse")),
        ],)

      ],),
      )
      
    );
  }
}


class EditSkillCard extends StatelessWidget {
  const EditSkillCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(top: 20),

      height: 150,
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
          child: Text("Edit SKILL",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),
        TextButton(onPressed: (){}, child: Text("Edit")) ,

      ],) ,),


      
      EditedCard(),

      ], 
      )
      
    );
  }
}

TextEditingController editNumberSkillController = TextEditingController();
TextEditingController editFieldSkillController = TextEditingController();

class EditedCard extends StatelessWidget {
  const EditedCard({ Key? key }) : super(key: key);

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
        Container(
          width: MediaQuery.of(context).size.width*0.18,
          child: TextField(
            controller: editNumberSkillController,
            decoration: InputDecoration(
            hintText: "Field number",
            suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.countertops),
             ),
              ),
              ),) ,
            Container(
              width: MediaQuery.of(context).size.width*0.68,
              child: TextField(
            controller: editFieldSkillController,
            decoration: InputDecoration(
            hintText: "Edit field",
            suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.check),
             ),
              ),
              ),) 

            

      ],)
        

    
      )
      
    );
  }
}

