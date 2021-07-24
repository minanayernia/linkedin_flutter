

// import 'dart:html';

// import 'dart:js_util';

import 'package:dbproject/models/Endorse.dart';
import 'package:dbproject/models/Notification.dart';
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
  const SkillCard(this.id , this.text , this.db);
  final id ;
  final text ;
  final AppDatabase db ;
   



  @override
  _SkillCardState createState() => _SkillCardState();
}


class _SkillCardState extends State<SkillCard> {

  

List<String?> endorseName =[];
void getindorse()async{
  print("get indorse ");
  print(widget.id);
      widget.db.endorseDao.findAllEndorse(int.parse(widget.id)).then((value) => setState((){
        if(value!=null){
          for(int i = 0 ; i< value.length ; i++){
            print("finding each endorsement");
            var us = value[i]?.userId;
            widget.db.userDao.findUserNameByUserId(us!).then((val) => setState((){
              var name = val?.userName ;
              endorseName.add(name);
              print("endorsement added to list");
            }));

          }
        }
      }));
    }
  void deleteSkill()async{
    widget.db.endorseDao.findAllEndorse(int.parse(widget.id)).then((value) => setState((){
      for (var end in value){
        var endId = end?.endorseId ;
        print("we find the endorse :$endId");
        widget.db.endorseDao.deleteEndorse(endId!);
        print("endorse deleted successfully");
      }
      widget.db.skillDao.deleteSkillById(int.parse(widget.id));
      print("skill deleted successfully");
    }));
  }
    
  @override
  void initState() {
    getindorse();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: 5 , bottom: 5),
      height: 70,
      width: MediaQuery.of(context).size.width*0.86,
      color: Colors.redAccent,
      child: Container(margin: EdgeInsets.only(left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(children: [
              Text(widget.id , style: TextStyle(color: Colors.white),) ,
              Container(
                padding: EdgeInsets.only(left: 5),
                child: Text(widget.text , style: TextStyle(color: Colors.white),),),
            TextButton(onPressed: () => deleteSkill(), child: Text("DELETE"))
              


          ],),
          Text("ENDORSED BY :" , style: TextStyle(color: Colors.white),),
          Container(
            height: 20,
            width: MediaQuery.of(context).size.width*0.86,
            child:
       ListView.builder(
         scrollDirection: Axis.horizontal,
        itemCount: endorseName.length,
        itemBuilder: (_,index) { 
          return Container(
            child: Container(
              // alignment: Alignment.center,
              color: Colors.white,
              child:Text(endorseName[index].toString() + "  " , style: TextStyle(color: Colors.redAccent),) ,)
            
            );
          ;}))
        ],)
          
        // Row(children: [
        //   // TextButton(onPressed: (){}, child: Text("Endorse")),
        //   TextButton(onPressed: (){}, child: Text("Edit")),
        // ],)

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
  list.add(new SkillCard(id , text , widget.db));
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
        TextButton(onPressed:(){}, child: Text("Add skill")) ,

      ],) ,),
        // TextButton(onPressed: test, child: Text("test")),

      Flexible(child:
       ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) { 
          return SkillCard(list[index].id.toString(), list[index].text , widget.db);
          ;}))
      
      ] 
      ,)
      
      
    );
  }
}

var otherSkill ;
 List<OtherSkillCard> otherList = [];
class OtherSkill extends StatefulWidget {
  const OtherSkill(this.db , this.user , this.myid);
  final AppDatabase db ;
  final int? user  ;
  final myid ;

  @override
  _OtherSkillState createState() => _OtherSkillState();
}

class _OtherSkillState extends State<OtherSkill> {

      List accomplishmentsText = [] ;
    List accomplishmentsId = [] ;

void addSkillCard(var id , var text , var myid){
  
  otherList.add(new OtherSkillCard(id , text , myid ,widget.db,widget.user));
  setState((){});
}

  void getSkill()async{
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
                  addSkillCard(value[i]?.SkillId , value[i]?.SkillText ,widget.myid );
                  var li = otherList[i].text;
                  print("$i , $li");
                }
                
              }
             }
          }));
          print(otherSkill);
          }
      }));
    }

    
    // print("this my profileid $profileId");
    
  }
  @override
  void initState() {
    getSkill();
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
          height: 30 ,
          margin: EdgeInsets.only(left: 10 , top: 7),
          child: Text("SKILLS&ENDORSEMENTS",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),

      ],) ,),
        


        Flexible(child:
       ListView.builder(
        itemCount: otherList.length,
        itemBuilder: (_,index) { 
          return OtherSkillCard(otherList[index].id.toString(), otherList[index].text , widget.myid , widget.db , widget.user);
          }))
      // OtherSkillCard(),
      /*Flexible(child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) => list[index]))*/
      
      ] 
      ,)
      
    );
  }
}

// class OtherSkill extends StatelessWidget {
//   const OtherSkill({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 20),

//       height: 200,
//       width: MediaQuery.of(context).size.width*0.9,
//       color: Colors.black87,
//       child:
//       Column(children: [

//         Container(
//           color: Colors.redAccent,
//           child:Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//         Container(
//           height: 30 ,
//           margin: EdgeInsets.only(left: 10 , top: 7),
//           child: Text("SKILLS&ENDORSEMENTS",
//           style: TextStyle(color: Colors.white , fontSize: 15),
//           ),
//         ),

//       ],) ,),
        
//       // OtherSkillCard(),
//       /*Flexible(child: ListView.builder(
//         itemCount: list.length,
//         itemBuilder: (_,index) => list[index]))*/
      
//       ] 
//       ,)
      
//     );
//   }
// }


class OtherSkillCard extends StatefulWidget {
  const OtherSkillCard(this.id , this.text , this.myid , this.db , this.otheruserid);
  final id ;
  final text ;
  final myid ;
  final AppDatabase db;
  final otheruserid ;

  @override
  _OtherSkillCardState createState() => _OtherSkillCardState();
}

class _OtherSkillCardState extends State<OtherSkillCard> {

  void addendorsementToDatabase()async{
    if(widget.myid != widget.otheruserid){
      widget.db.endorseDao.findEndoseByUserAndSkill(int.parse(widget.id), widget.myid).then((value) => setState((){
        if(value == null){
          print("addendorsementToDatabase if");
      var endorse = Endorse(userId :widget.myid,skillId: int.parse(widget.id));
      print("endorse : $endorse");
      widget.db.endorseDao.insertEndorse(endorse);
      print("endorse inserted successfuly!");
      //add endorse notif
        var notif = Notificationn(notificationType: 6, receiver: widget.otheruserid, sender: widget.myid);
        widget.db.notificationnDao.insertNotif(notif);
        print("notif endorsement sent!");
        //end
        }

      }));

      
      
    }
    
    
  }
  List<String?> endorseName =[];
  void getindorse()async{
  print("get indorse ");
  print(widget.id);
      widget.db.endorseDao.findAllEndorse(int.parse(widget.id)).then((value) => setState((){
        if(value!=null){
          for(int i = 0 ; i< value.length ; i++){
            print("finding each endorsement");
            var us = value[i]?.userId;
            widget.db.userDao.findUserNameByUserId(us!).then((val) => setState((){
              var name = val?.userName ;
              endorseName.add(name);
              print("endorsement added to list");
            }));

          }
        }
      }));
    }
    @override
    void initState() {
    getindorse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10 , bottom: 5),
      height: 70,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.redAccent,
      child: Container(margin: EdgeInsets.only(left: 5),
      child:Column(children: [
            Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Row(children: [
            Text(widget.id , style: TextStyle(color: Colors.white),) ,
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Text(widget.text , style: TextStyle(color: Colors.white),),)
            


        ],),
        Row(children: [
          TextButton(onPressed: (){
            return addendorsementToDatabase();
          }, child: Text("Endorse")),
        ],)

      ],),


        Text("ENDORSED BY :" , style: TextStyle(color: Colors.white),),
          Container(
            height: 20,
            width: MediaQuery.of(context).size.width*0.86,
            child:
       ListView.builder(
         scrollDirection: Axis.horizontal,
        itemCount: endorseName.length,
        itemBuilder: (_,index) { 
          return Container(
            child: Container(
              // alignment: Alignment.center,
              color: Colors.white,
              child:Text(endorseName[index].toString() + "  " , style: TextStyle(color: Colors.redAccent),) ,)
            
            );
          ;})
      )],)
      
      )
      
    );
  }
}

// class OtherSkillCard extends StatelessWidget {
//   const OtherSkillCard({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 10 , bottom: 5),
//       height: 50,
//       width: MediaQuery.of(context).size.width*0.88,
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
//         ],)

//       ],),
//       )
      
//     );
//   }
// }

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
    list.add(new SkillCard(id , text , widget.db));
    setState((){});
    }
  }

  void addSkillToDatabase(String skillText)async{
    print("in addSkillToDatabase ");
    
    var a = widget.user ;
    print(widget.user);
    if(a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((value) => setState((){
        print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      if(value != null){
        var checkCopyField ;
          widget.db.skillDao.findSkillByName(skillText , value.ProfileId!).then((v) => setState((){
            if (v != null ){
             print("find skill by name is not null");
             checkCopyField = v ;
             checkCopy = true ;

          }else{
        print("find skill by name is null");
        checkCopyField = null ;
        checkCopy = false ;
        if(skillText != "" && checkCopyField == null){
          var profileId ;
    var skill ;
      widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
        if (val != null) {
          profileId = val.ProfileId;
          print("this profileid in test card $profileId");
          skill = Skill(SkillText: skillText ,profileId: profileId);
          widget.db.skillDao.insertSkill(skill);
          }
      }
      
      ));
      addSkillController.text = ''  ;
    }
      }
    }));
        
        // print("profid : $profid");
      }
      else{
        print("null in find userprofile");
      }
    }));
    }
    
    

    // var a = widget.user;
    

    // setState(() {
    //   if(checkCopyField != null){
    //     checkCopy = true ;
    //   }
    //   if(checkCopyField == null){
    //     checkCopy = false ;
    //   }
    // });

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


    


  }


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
  bool checkEditFieldName = false  ;
  bool checkEditFieldNumber = false ;
  void editSkillINDatabase(var skillText , String idNumber)async{

    setState(() {
      if(idNumber == ""){
        checkEditFieldNumber = true ;
      }
      if(idNumber != ""){
        checkEditFieldNumber = false ;
      }
    });

    if(idNumber != ""){

    int id = int.parse(editNumberSkillController.value.text);
    var a = widget.user;
    if(a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((value) => setState((){
        print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      if(value != null){
        var checkFieldNumber ;
          widget.db.skillDao.findSkillById(id , value.ProfileId!).then((v) => setState((){
            if (v != null ){
             print("find skill by name is not null");
             checkFieldNumber = v ;
             checkEditFieldNumber = false ;
             if(skillText != "" && checkFieldNumber != null){
          print("this is userid:");
      print(a);
      widget.db.skillDao.editSkill(skillText, id) ;
      widget.db.skillDao.findSkillById(id , value.ProfileId!).then((val) => setState((){
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

          }else{
        print("find skill by name is null");
        checkFieldNumber = null ;
        checkEditFieldNumber = true ;

      }
    }));
        
        // print("profid : $profid");
      }
      else{
        print("null in find userprofile");
      }
    }));
    }
    // final checkFieldNumber = await widget.db.skillDao.findSkillById(id);
    // setState(() {
    //   if (checkFieldNumber == null){
    //     checkEditFieldNumber = true ;
    //   }
    //   if (checkFieldNumber != null){
    //     checkEditFieldNumber = false ;
    //   }
    // });
    setState(() {
      if(skillText == ""){
        checkEditFieldName = true ;
      }
      if(skillText != ""){
        checkEditFieldName = false ;
      }

    });

  //   if(skillText != "" && checkFieldNumber != null){
    
  //   if (a != null){
  //     print("this is userid:");
  //     print(a);
  //     await widget.db.skillDao.editSkill(skillText, id) ;
  //     widget.db.skillDao.findSkillById(id).then((val) => setState((){
  //       print("we are in editskilldatabase");
  //       print(val?.SkillId);
  //       if (val != null){
  //         print("skilltext is going to change");
  //         skillText = val.SkillText ;
  //         }
  //         else{
  //           print("value is null");
  //         }
  //     }));
  //   }
  // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 100,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.redAccent,
      child: Container(margin: EdgeInsets.only(left: 5),
      child: Column(children: [


        Row(
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
              return editSkillINDatabase(editFieldSkillController.value.text.toString(), editNumberSkillController.value.text);
            },
            icon: Icon(Icons.check),
             ),
              ),
              ),)     

      ],),

        Container(
          alignment: Alignment.center,
          child: Visibility(
          visible: checkEditFieldName,
          child: Container(child: Text("Edit filed can't be empty" , style: TextStyle(color: Colors.white),),),),),

          Container(
          alignment: Alignment.center,
          child: Visibility(
          visible: checkEditFieldNumber,
          child: Container(child: Text("No such field exists" , style: TextStyle(color: Colors.white),),),),),

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

