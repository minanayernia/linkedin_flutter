

// import 'dart:html';

import 'package:dbproject/models/Skill.dart';
import 'package:flutter/material.dart';

import '../database.dart';

List<SkillCard> list = [];

// class SkillsAndEndorsements extends StatelessWidget {
//   const SkillsAndEndorsements({ Key ?key }) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
      
//     );
//   }
// }

class SkillCard extends StatefulWidget {
  const SkillCard(this.id , this.text);
  final id ;
  final text ;
   



  @override
  _SkillCardState createState() => _SkillCardState();
}


class _SkillCardState extends State<SkillCard> {

    

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
            Text(widget.id , style: TextStyle(color: Colors.white),) ,
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Text(widget.text , style: TextStyle(color: Colors.white),),)
            


        ],),
        Row(children: [
          // TextButton(onPressed: (){}, child: Text("Endorse")),
          TextButton(onPressed: (){}, child: Text("Edit")),
        ],)

      ],),
      )
    );
  }
}


// class SkillCard extends StatelessWidget {
//   const SkillCard({ Key ?key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 5 , bottom: 5),
//       height: 50,
//       width: MediaQuery.of(context).size.width*0.86,
//       color: Colors.redAccent,
//       child: Container(margin: EdgeInsets.only(left: 5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//         Row(children: [
//             Text("1" , style: TextStyle(color: Colors.white),) ,
//             Container(
//               padding: EdgeInsets.only(left: 5),
//               child: Text("Skill" , style: TextStyle(color: Colors.white),),)
            


//         ],),
//         Row(children: [
//           TextButton(onPressed: (){}, child: Text("Endorse")),
//           TextButton(onPressed: (){}, child: Text("Edit")),
//         ],)

//       ],),
//       )
      
//     );
//   }
// }



class AddSkill extends StatefulWidget {

  const AddSkill(this.db , this.user);
  final AppDatabase db ;
  final int? user  ;  
 

  @override
  _AddSkillState createState() => _AddSkillState();
}

class _AddSkillState extends State<AddSkill> {
     
      List skillsText = [] ;
    List skillsId = [] ;

void addSkillCard(int id , String text){
  
  list.add(new SkillCard(id , text));
  setState((){});
}

// void addSkillDatabase(String text ){
//     var a = widget.user;
//     var profileId ;
//     if (a != null){
//       widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
//         if (val != null){
//           profileId = val.ProfileId;
//           }
//       }));
//     }
//     var skill = Skill(text, profileId) ;
//     if (a != null ){
//       widget.db.skillDao.insertSkill(skill);
//       addSkillCard(profileId, text) ;
//     }
//   }

  void getSkills()async{
    var a = widget.user;
    var profileId ;
   

    if (a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
        if (val != null){
          profileId = val.ProfileId;
          }
      }));
    }
    if (a != null ){
      widget.db.skillDao.allSkills(profileId).then((value) => setState((){
        if (value != null){
          int i = 0 ;
          for (i = 0 ; i < value.length; i++){
            if (value[i] != null){
              print("in all skills");
              skillsId[i]= value[i]?.SkillId;
              print(skillsId[i]);
              skillsText[i] = value[i]?.SkillText;
              print(skillsText[i]);
            }else{

            }
            
          }
        }
      }));

    }
    for (int i = 0 ; i < skillsId.length ; i++){
      addSkillCard(skillsId[i], skillsText[i]);
    }

  }
  var skill ;
  void test()async{
    var a = widget.user;
    var profileId ;
   

    if (a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
        if (val != null){
          profileId = val.ProfileId;
          }
      }));
    }

    skill = Skill("java" , profileId);
    print("this my profileid $profileId");
    await widget.db.skillDao.insertSkill(skill);
    // addSkillCard(profileId , "java");
    print(skill);
  }

  
  @override
  void initState() {
    getSkills();
    super.initState();
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
        TextButton(onPressed: null, child: Text("Add skill")) ,

      ],) ,),
        TextButton(onPressed: test, child: Text("test"))

      // Flexible(child:
      //  ListView.builder(
      //   itemCount: list.length,
      //   itemBuilder: (_,index) => list[index]))
      
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

class EditSkillCard extends StatefulWidget {
  const EditSkillCard(this.db , this.user) ;
  final AppDatabase db ;
  final int? user  ; 

  @override
  _EditSkillCardState createState() => _EditSkillCardState();
}

class _EditSkillCardState extends State<EditSkillCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(top: 20),

      height: 250,
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
          child: Text("ADD/EDIT SKILL",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),
        TextButton(onPressed: (){}, child: Text("Edit")) ,

      ],) ,),


      
      Container(
        
        child: SingleChildScrollView(child: Column(children: [
              NewSkill(widget.db , widget.user),
              EditedCard(),
      ],),),)

      ], 
      )
      
    );
  }
}


// class EditSkillCard extends StatelessWidget {
//   const EditSkillCard({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//             margin: EdgeInsets.only(top: 20),

//       height: 250,
//       width: MediaQuery.of(context).size.width*0.9,
//       color: Colors.black87,
//       child: 
//       Column(children: [
//         Container(
//           color: Colors.redAccent,
//           child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//         Container(
          
//           margin: EdgeInsets.only(left: 10),
//           child: Text("ADD/EDIT SKILL",
//           style: TextStyle(color: Colors.white , fontSize: 15),
//           ),
//         ),
//         TextButton(onPressed: (){}, child: Text("Edit")) ,

//       ],) ,),


      
//       Container(
        
//         child: SingleChildScrollView(child: Column(children: [
//               NewSkill(),
//               EditedCard(),
//       ],),),)

//       ], 
//       )
      
//     );
//   }
// }



TextEditingController addSkillController = TextEditingController();


class NewSkill extends StatefulWidget {
  const NewSkill(this.db , this.user);
  final AppDatabase db ;
  final int? user  ;  

  @override
  _NewSkillState createState() => _NewSkillState();
}

class _NewSkillState extends State<NewSkill> {

void addSkillCard(int id , String text){
  
  list.add(new SkillCard(id , text));
  setState((){});
}
  
void addSkillDatabase(String text ){
    var a = widget.user;
    var profileId ;
    if (a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
        if (val != null){
          profileId = val.ProfileId;
          }
      }));
    }
    var skill = Skill(text, profileId) ;
    if (a != null ){
      widget.db.skillDao.insertSkill(skill);
      addSkillCard(profileId, text) ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width*0.86,
          margin: EdgeInsets.only(left: 10),
          child: TextField(
            controller: addSkillController,
            decoration: InputDecoration(
            hintText: "Skill name",
            hintStyle: TextStyle(color: Colors.redAccent),
            suffixIcon: IconButton(onPressed: () => addSkillDatabase(addSkillController.text) , icon : Icon(Icons.check)),
            
            ),
            
            
          )
        ),
        

      ],),
      
    );
  }
}

// class NewSkill extends StatelessWidget {
//   const NewSkill({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       width: MediaQuery.of(context).size.width*0.88,
//       color: Colors.white,
//       margin: EdgeInsets.only(top: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//         Container(
//           color: Colors.white,
//           width: MediaQuery.of(context).size.width*0.86,
//           margin: EdgeInsets.only(left: 10),
//           child: TextField(
//             controller: addSkillController,
//             decoration: InputDecoration(
//             hintText: "Skill name",
//             hintStyle: TextStyle(color: Colors.redAccent),
//             suffixIcon: IconButton(onPressed: , icon : Icon(Icons.check)),
            
//             ),
            
            
//           )
//         ),
        

//       ],),
      
//     );
//   }
// }

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

