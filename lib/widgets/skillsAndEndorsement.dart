

// import 'dart:html';

// import 'dart:js_util';

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

void addSkillCard(var id , var text){
  setState(() {
    if(text == ""){
    checkSkillField = true ;
  }
  });
  
  if(text != "" && checkCopy == false){
  list.add(new SkillCard(id , text));
  setState((){});
  }
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
        if (val != null) {
          profileId = val.ProfileId;
          // print("this profileid in test card $profileId");
          // skill = Skill(SkillText: "android" ,profileId: profileId);
          // widget.db.skillDao.insertSkill(skill);q
          widget.db.skillDao.allSkills(profileId).then((value) => setState((){
             if (value != null){
              for (int i = 0 ; i < value.length ; i++){
                if (value[i] != null){
                  print(value[i]?.SkillText);
                  print("this is the skillid :");
                  print(value[i]?.SkillId);
                  addSkillCard(value[i]?.SkillId , value[i]?.SkillText );
                  var li = list[i].text;
                  print("$i , $li");
                }
                
              }
             }
          }));
          print(skill);
          }
      }));
    }

    
    // print("this my profileid $profileId");
    
  }

  var skill ;
  void test()async{
    var a = widget.user;
    var profileId ;
   

    if (a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
        if (val != null) {
          profileId = val.ProfileId;
          print("this profileid in test card $profileId");
          skill = Skill(SkillText: "android" ,profileId: profileId);
          widget.db.skillDao.insertSkill(skill);
          widget.db.skillDao.allSkills(profileId).then((value) => setState((){
             if (value != null){
              for (int i = 0 ; i < value.length ; i++){
                if (value[i] != null){
                  print(value[i]?.SkillText);
                  print("this is the skillid :");
                  print(value[i]?.SkillId);
                  addSkillCard(value[i]?.SkillId , value[i]?.SkillText );
                  var li = list[i].text;
                  print("$i , $li");
                }
                
              }
             }
          }));
          print(skill);
          }
      }));
    }

    
    // print("this my profileid $profileId");
    
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
        // TextButton(onPressed: test, child: Text("test")),

      Flexible(child:
       ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) { 
          return SkillCard(list[index].id.toString(), list[index].text);
          ;}))
      
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

bool checkSkillField = false ;
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
              EditedCard(widget.db , widget.user),
      ],),),),




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

bool checkCopy = false ;
class NewSkill extends StatefulWidget {
  const NewSkill(this.db , this.user);
  final AppDatabase db ;
  final int? user  ;  

  @override
  _NewSkillState createState() => _NewSkillState();
}

class _NewSkillState extends State<NewSkill> {

  

  void addSkillCard(var id , var text){
    if(text != ""&& checkCopy == false){
    list.add(new SkillCard(id , text));
    setState((){});
    }
  }

  void addSkillToDatabase(String skillText)async{
    final checkCopyField = await widget.db.skillDao.findSkillByName(skillText) ;

    var a = widget.user;
    var profileId ;
    var skill ;

    setState(() {
      if(checkCopyField != null){
        checkCopy = true ;
      }
      if(checkCopyField == null){
        checkCopy = false ;
      }
    });

    setState(() {
      if (skillText == ""){
      checkSkillField = true ;
      print("YYYYYYYYYYYYYYYYYYYYYYYY") ;
    }
  
    });
    setState(() {
      if (skillText != ""){
      checkSkillField = false;
      print("YYYYYYYYYYYYYYYYYYYYYYYY") ;
    }
  
    });


    if(skillText != "" && checkCopyField == null){
    if (a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
        if (val != null) {
          profileId = val.ProfileId;
          print("this profileid in test card $profileId");
          skill = Skill(SkillText: skillText ,profileId: profileId);
          widget.db.skillDao.insertSkill(skill);
          // widget.db.skillDao.allSkills(profileId).then((value) => setState((){
          //    if (value != null){
          //     for (int i = 0 ; i < value.length ; i++){
          //       if (value[i] != null){
          //         // addSkillCard(id, text)
          //         print(value[i]?.SkillText);
          //         print("this is the skillid :");
          //         print(value[i]?.SkillId);
          //         addSkillCard(value[i]?.SkillId , value[i]?.SkillText );
          //         var li = list[i].text;
          //         print("$i , $li");
          //       }
                
          //     }
          //    }
          // }));
          // print(skill);
          }
      }
      
      ));
      addSkillController.text = ''  ;
    }
    }

    
    // print("this my profileid $profileId");


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
//     var skill = Skill(SkillText:text,profileId: profileId) ;
//     if (a != null ){
//       widget.db.skillDao.insertSkill(skill);
//       addSkillCard(profileId, text) ;
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      child: Column(
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
            suffixIcon: IconButton(onPressed: () => addSkillToDatabase(addSkillController.text) , icon : Icon(Icons.check)),
            
            ),
            
            
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Visibility(
          visible: checkSkillField,
          child: Container(child: Text("Field name can't be empty" , style: TextStyle(color: Colors.redAccent),),),),),

          Container(
          alignment: Alignment.center,
          child: Visibility(
          visible: checkCopy,
          child: Container(child: Text("This field already exists" , style: TextStyle(color: Colors.redAccent),),),),),
        
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
var skillText ;
class EditedCard extends StatefulWidget {
  const EditedCard(this.db , this.user) ;
  final AppDatabase db ;
  final int? user  ;  


  @override
  _EditedCardState createState() => _EditedCardState();
}

class _EditedCardState extends State<EditedCard> {

  void editSkillINDatabase(var skillText , int id)async{

    var a = widget.user;
    if (a != null){
      print("this is userid:");
      print(a);
      await widget.db.skillDao.editSkill(skillText, id) ;
      widget.db.skillDao.findSkillById(id).then((val) => setState((){
        print("we are in editskilldatabase");
        print(val?.SkillId);
        if (val != null){
          print("skilltext is going to change");
          skillText = val.SkillText ;
          }
          else{
            print("value is null");
          }
      }));
    }
  }

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
            onPressed: () {
              return editSkillINDatabase(editFieldSkillController.value.text.toString(), int.parse(editNumberSkillController.value.text));
            },
            icon: Icon(Icons.check),
             ),
              ),
              ),) 

            

      ],)
        

    
      )
      
    );
  }
}

// class EditedCard extends StatelessWidget {
//   const EditedCard({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 10),
//       height: 50,
//       width: MediaQuery.of(context).size.width*0.88,
//       color: Colors.redAccent,
//       child: Container(margin: EdgeInsets.only(left: 5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//         Container(
//           width: MediaQuery.of(context).size.width*0.18,
//           child: TextField(
//             controller: editNumberSkillController,
//             decoration: InputDecoration(
//             hintText: "Field number",
//             suffixIcon: IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.countertops),
//              ),
//               ),
//               ),) ,
//             Container(
//               width: MediaQuery.of(context).size.width*0.68,
//               child: TextField(
//             controller: editFieldSkillController,
//             decoration: InputDecoration(
//             hintText: "Edit field",
//             suffixIcon: IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.check),
//              ),
//               ),
//               ),) 

            

//       ],)
        

    
//       )
      
//     );
//   }
// }

